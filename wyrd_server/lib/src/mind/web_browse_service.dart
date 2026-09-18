import 'package:puppeteer/puppeteer.dart' as pptr;
import 'browser_safety.dart';

class WebSnapshot {
  final String url;
  final String title;
  final String text;
  final String? screenshotBase64;

  WebSnapshot({required this.url, required this.title, required this.text, this.screenshotBase64});
}

class WebSession {
  final pptr.BrowserContext context;
  final pptr.Page page;

  WebSession(this.context, this.page);
}

/// Ports server.js's getSharedBrowser/openWebSession/webOpen/webType/webClick using
/// puppeteer-dart (a real Dart port of Puppeteer, driving real headless Chrome over the
/// DevTools protocol) in place of Node's puppeteer package. One throwaway incognito context
/// per chat reply that uses these tools -- never shared between users or reused across turns.
class WebBrowseService {
  static const actionTimeout = Duration(seconds: 12);

  static pptr.Browser? _browser;
  static Future<pptr.Browser>? _browserLaunch;

  static Future<pptr.Browser> _getSharedBrowser() {
    if (_browser != null) return Future.value(_browser);
    _browserLaunch ??= pptr.puppeteer.launch(headless: true, noSandboxFlag: true).then((b) {
      _browser = b;
      return b;
    });
    return _browserLaunch!;
  }

  static Future<WebSession> openSession() async {
    final browser = await _getSharedBrowser();
    final context = await browser.createIncognitoBrowserContext();
    final page = await context.newPage();
    await page.setViewport(pptr.DeviceViewport(width: 1280, height: 800));
    return WebSession(context, page);
  }

  static Future<void> closeSession(WebSession? session) async {
    if (session == null) return;
    try {
      await session.context.close();
    } catch (_) {
      // best-effort cleanup, same as Node's .catch(() => {})
    }
  }

  static Future<WebSnapshot> _snapshot(pptr.Page page) async {
    String title = '';
    String text = '';
    String? screenshot;
    try {
      title = await page.title ?? '';
    } catch (_) {}
    try {
      text = await page.evaluate<String>(
        'function() { return document.body ? document.body.innerText : ""; }',
      );
    } catch (_) {}
    try {
      screenshot = await page.screenshotBase64(format: pptr.ScreenshotFormat.jpeg, quality: 65);
    } catch (_) {}

    return WebSnapshot(
      url: page.url ?? '',
      title: title,
      text: text.length > 3000 ? text.substring(0, 3000) : text,
      screenshotBase64: screenshot,
    );
  }

  static Future<WebSnapshot> open(WebSession session, String rawUrl) async {
    final uri = await BrowserSafety.assertSafePublicUrl(rawUrl);
    await session.page.goto(uri.toString(), wait: pptr.Until.domContentLoaded, timeout: actionTimeout);
    return _snapshot(session.page);
  }

  // No CSS selectors from the model -- it only gets a plain-English hint ("search box", "Sign
  // in"). Matching happens by real page attributes (placeholder/aria-label/name/type), far
  // more robust than asking an LLM to guess DOM selectors it's never seen.
  static Future<WebSnapshot> type(WebSession session, String hint, String text) async {
    final found = await session.page.evaluate<bool>(
      '''
      function(hint) {
        const inputs = [...document.querySelectorAll('input, textarea')].filter((el) => {
          const style = getComputedStyle(el);
          return style.display !== 'none' && style.visibility !== 'hidden' && el.offsetParent !== null;
        });
        const h = (hint || '').toLowerCase();
        const score = (el) => {
          const hay = [el.placeholder, el.getAttribute('aria-label'), el.name, el.id, el.type]
            .filter(Boolean).join(' ').toLowerCase();
          if (h && hay.includes(h)) return 2;
          if (el.type === 'search' || el.type === 'text' || el.tagName === 'TEXTAREA') return 1;
          return 0;
        };
        let best = null, bestScore = -1;
        for (const el of inputs) {
          const s = score(el);
          if (s > bestScore) { bestScore = s; best = el; }
        }
        if (!best) return false;
        best.setAttribute('data-wyrd-target', '1');
        return true;
      }
      ''',
      args: [hint],
    );
    if (!found) throw Exception('no matching input field found for "$hint"');

    await session.page.click('[data-wyrd-target="1"]', clickCount: 3);
    await session.page.type('[data-wyrd-target="1"]', text, delay: const Duration(milliseconds: 15));
    await session.page.evaluate<void>(
      "function() { const el = document.querySelector('[data-wyrd-target=\"1\"]'); if (el) el.removeAttribute('data-wyrd-target'); }",
    );
    return _snapshot(session.page);
  }

  static Future<WebSnapshot> click(WebSession session, String hint) async {
    final found = await session.page.evaluate<bool>(
      '''
      function(hint) {
        const h = (hint || '').toLowerCase();
        const candidates = [...document.querySelectorAll('a, button, input[type="submit"], input[type="button"], [role="button"]')]
          .filter((el) => {
            const style = getComputedStyle(el);
            return style.display !== 'none' && style.visibility !== 'hidden' && el.offsetParent !== null;
          });
        const text = (el) => (el.innerText || el.value || el.getAttribute('aria-label') || '').trim().toLowerCase();
        let best = candidates.find((el) => text(el) === h);
        if (!best) best = candidates.find((el) => text(el).includes(h));
        if (!best) return false;
        best.setAttribute('data-wyrd-target', '1');
        best.scrollIntoView({ block: 'center' });
        return true;
      }
      ''',
      args: [hint],
    );
    if (!found) throw Exception('no matching clickable element found for "$hint"');

    try {
      await session.page.clickAndWaitForNavigation(
        '[data-wyrd-target="1"]',
        timeout: actionTimeout,
        wait: pptr.Until.domContentLoaded,
      );
    } catch (_) {
      // navigation didn't happen (e.g. the click just toggled something in-page) -- fine,
      // same as Node's .catch(() => {}) on waitForNavigation.
    }
    return _snapshot(session.page);
  }
}
