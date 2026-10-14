import 'package:web/web.dart' as web;

/// The words on the page right now, from the accessibility tree Flutter mirrors into the web page
/// (switched on in main.dart), so WYRD knows what is on the screen it's asked about.
String pageText() {
  final host = web.document.querySelector('flt-semantics-host');
  final text = (host?.textContent ?? '')
      .replaceAll(RegExp(r'[ \t]+'), ' ')
      .replaceAll(RegExp(r'\n\s*\n+'), '\n')
      .trim();
  return text.length > 9000 ? text.substring(0, 9000) : text;
}

/// A setting kept in this browser between visits (what WYRD changed with customize_app).
String? loadLocal(String key) {
  try {
    return web.window.localStorage.getItem(key);
  } catch (_) {
    return null;
  }
}

void saveLocal(String key, String? value) {
  try {
    if (value == null) {
      web.window.localStorage.removeItem(key);
    } else {
      web.window.localStorage.setItem(key, value);
    }
  } catch (_) {}
}
