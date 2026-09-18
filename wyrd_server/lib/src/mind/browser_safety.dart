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
    if (address.type == InternetAddressType.IPv4) {
      final parts = address.rawAddress;
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
      if (lower == '::1') return true;
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
}
