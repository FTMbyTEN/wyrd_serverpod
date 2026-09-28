import 'dart:io';

/// Ports server.js's assertSafeBrowseUrl/assertSafePublicBrowseUrl/isPrivateIp -- rejects
/// anything that isn't a plain http(s) URL, then resolves the hostname and refuses one that
/// points at a private/internal network (SSRF guard), so a chat message can't be used to make
/// the server's own browser probe its internal network or localhost services.
class BrowserSafety {
  static Uri assertSafeUrl(String rawUrl) {
    late final Uri uri;
    try {
      uri = Uri.parse(rawUrl);
    } catch (_) {
      throw Exception('not a valid URL');
    }
    if (uri.scheme != 'http' && uri.scheme != 'https') {
      throw Exception('only http/https URLs are allowed');
    }
    return uri;
  }

  static bool isPrivateIp(InternetAddress address) {
    if (address.type == InternetAddressType.IPv6) {
      final raw = address.rawAddress;
      // IPv4-mapped (::ffff:a.b.c.d): judge the IPv4 address inside
      final mapped = raw.length == 16 && raw.sublist(0, 10).every((b) => b == 0) && raw[10] == 0xff && raw[11] == 0xff;
      if (mapped) return isPrivateIp(InternetAddress.fromRawAddress(raw.sublist(12), type: InternetAddressType.IPv4));
    }
    if (address.type == InternetAddressType.IPv4) {
      final parts = address.rawAddress;
      if (parts[0] == 100 && parts[1] >= 64 && parts[1] <= 127) return true; // carrier-grade NAT
      if (parts[0] >= 224) return true; // multicast, reserved, broadcast
      if (parts[0] == 10) return true;
      if (parts[0] == 127) return true;
      if (parts[0] == 169 && parts[1] == 254) return true;
      if (parts[0] == 172 && parts[1] >= 16 && parts[1] <= 31) return true;
      if (parts[0] == 192 && parts[1] == 168) return true;
      if (parts[0] == 0) return true;
      return false;
    }
    if (address.type == InternetAddressType.IPv6) {
      final lower = address.address.toLowerCase();
      if (lower == '::1' || lower == '::') return true;
      if (lower.startsWith('fc') || lower.startsWith('fd')) return true;
      if (lower.startsWith('fe80')) return true;
      return false;
    }
    return true; // couldn't parse -- refuse rather than guess
  }

  static Future<Uri> assertSafePublicUrl(String rawUrl) async {
    final uri = assertSafeUrl(rawUrl);
    if (uri.host == 'localhost') throw Exception('cannot browse to localhost');

    List<InternetAddress> addresses;
    try {
      addresses = await InternetAddress.lookup(uri.host);
    } catch (_) {
      throw Exception('could not resolve ${uri.host}');
    }
    if (addresses.any(isPrivateIp)) {
      throw Exception('that address resolves to a private/internal network, not allowed');
    }
    return uri;
  }

  /// A public address for [host], checked at the moment of connecting.
  static Future<InternetAddress> resolvePublic(String host) async {
    if (host == 'localhost') throw Exception('cannot browse to localhost');
    final List<InternetAddress> addresses;
    try {
      addresses = await InternetAddress.lookup(host);
    } catch (_) {
      throw Exception('could not resolve $host');
    }
    if (addresses.isEmpty || addresses.any(isPrivateIp)) {
      throw Exception('that address resolves to a private/internal network, not allowed');
    }
    return addresses.first;
  }

  /// An HTTP client whose every connection goes to an address checked right then. Checking a
  /// name and then letting the client look it up again leaves a gap: a hostile DNS server can
  /// answer "public" to the check and "127.0.0.1" to the fetch (DNS rebinding). Here the address
  /// that was checked is the one connected to; TLS still verifies the certificate for the name.
  static HttpClient pinnedClient() {
    final client = HttpClient()
      ..findProxy = ((_) => 'DIRECT')
      ..connectionTimeout = const Duration(seconds: 15);
    client.connectionFactory = (Uri uri, String? proxyHost, int? proxyPort) async {
      final address = await resolvePublic(uri.host);
      final port = uri.hasPort ? uri.port : (uri.scheme == 'https' ? 443 : 80);
      final task = await Socket.startConnect(address, port);
      if (uri.scheme != 'https') return task;
      return ConnectionTask.fromSocket(
        task.socket.then((s) => SecureSocket.secure(s, host: uri.host)),
        task.cancel,
      );
    };
    return client;
  }
}
