import 'package:web/web.dart' as web;

/// The words on the page right now, from the accessibility tree Flutter mirrors into the web page
/// (switched on in main.dart), so WYRD knows what is on the screen it's asked about.
String pageText() {
  final host = web.document.querySelector('flt-semantics-host');
  final text = (host?.textContent ?? '')
      .replaceAll(RegExp(r'[ \t]+'), ' ')
      .replaceAll(RegExp(r'\n\s*\n+'), '\n')
      .trim();
  return text.length > 3500 ? text.substring(0, 3500) : text;
}
