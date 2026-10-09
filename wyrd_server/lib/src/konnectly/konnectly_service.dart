import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../mind/llm_service.dart';

/// WYRD's AI working for Konnectly (konnectly.xyz), the campus marketplace -- in demo mode: nobody
/// signs in and nothing touches Konnectly's own database. Two jobs (customer care is scripted, in
/// KonnectlyCare, and costs nothing):
///  - [writeListing]: a seller's photo becomes a ready listing (title, description, category,
///    condition, a fair campus price) and anything the marketplace doesn't allow is flagged;
///  - [checkReceipt]: reads a buyer's bank-transfer screenshot for the admin and says what looks off.
/// Every call runs through LlmService, so WYRD's daily spending cap still holds; on top of that the
/// demo has its own daily allowance ([dailyCalls], `konnectlyDemoDailyCalls` password) so a busy
/// demo can't spend the day's whole budget.
class KonnectlyService {
  static const _maxBase64Chars = 2800000; // ~2 MB of JPEG

  static int dailyCalls(Session session) => int.tryParse(session.passwords['konnectlyDemoDailyCalls'] ?? '') ?? 40;

  static String _day = '';
  static int _used = 0;

  /// Counts one demo call against today's allowance; false once it's spent.
  static bool take(Session session) {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    if (today != _day) {
      _day = today;
      _used = 0;
    }
    if (_used >= dailyCalls(session)) return false;
    _used++;
    return true;
  }

  static int left(Session session) {
    final today = DateTime.now().toUtc().toIso8601String().substring(0, 10);
    return today == _day ? (dailyCalls(session) - _used).clamp(0, 1 << 30) : dailyCalls(session);
  }

  static const _categories = 'Books & Notes, Electronics, Phones & Accessories, Computers, Fashion & Clothing, Shoes, '
      'Beauty & Personal Care, Furniture, Kitchen & Appliances, Hostel Essentials, Sports Gear, Food & Snacks, '
      'Services, Tickets & Events, Other';

  /// The first {...} in [text], parsed; null if there isn't a usable one.
  static Map<String, dynamic>? _json(String? text) {
    if (text == null) return null;
    final a = text.indexOf('{'), b = text.lastIndexOf('}');
    if (a < 0 || b <= a) return null;
    try {
      final v = jsonDecode(text.substring(a, b + 1));
      return v is Map<String, dynamic> ? v : null;
    } catch (_) {
      return null;
    }
  }

  static void _checkImage(String imageBase64Jpeg) {
    if (imageBase64Jpeg.isEmpty) throw Exception('add a photo first');
    if (imageBase64Jpeg.length > _maxBase64Chars) throw Exception('that photo is too large');
  }

  static String _clip(String? s, int n) {
    final t = (s ?? '').trim();
    return t.length <= n ? t : t.substring(0, n);
  }

  /// A seller's photo (and optional words about it) -> a listing, as JSON:
  /// {title, description, category, condition, priceLow, priceHigh, suggestedPrice, tags[], allowed, warnings[]}.
  static Future<String> writeListing(Session session, String imageBase64Jpeg, {String? note, String? campus}) async {
    _checkImage(imageBase64Jpeg);
    final system = 'You are WYRD, the AI behind Konnectly, a campus marketplace in Nigeria. A student or vendor has '
        'photographed something to sell. Write the listing for them: honest, specific, appealing to students, plain '
        'English (light Nigerian campus tone is fine, no slang overload). Describe only what you can see or what the '
        'seller told you -- never invent specs, brand, storage size or condition details you can\'t see; if something '
        'important is unknown, say "ask the seller" style hints in warnings instead. Prices are in Nigerian naira for a '
        'used/second-hand campus sale in 2026 unless it is clearly new; be realistic for students.\n'
        'Konnectly does NOT allow: anything illegal, stolen or counterfeit; weapons; drugs; alcohol or tobacco; exam '
        'questions or academic cheating services; adult content; live animals; financial products; anything dangerous. '
        'If the item is one of these, set allowed to false and explain in warnings. Also warn if the photo looks like a '
        'stock/catalogue image rather than the seller\'s own photo, or if it is too dark/blurry to sell from.\n'
        'Reply with ONLY a JSON object, no other text: {"title": string (max 60 chars), "description": string (2-4 '
        'short sentences), "category": one of [$_categories], "condition": one of ["New","Like new","Good","Fair",'
        '"For parts"], "priceLow": integer naira, "priceHigh": integer naira, "suggestedPrice": integer naira, "tags": '
        'array of up to 5 short search words, "allowed": boolean, "warnings": array of short strings (may be empty)}';
    final user = [
      if ((note ?? '').trim().isNotEmpty) 'What the seller says: ${_clip(note, 400)}',
      if ((campus ?? '').trim().isNotEmpty) 'Campus: ${_clip(campus, 120)}',
      'Write the listing for this photo.',
    ].join('\n');
    final reply = await LlmService.callWithImage(session, system, imageBase64Jpeg, user, 700);
    final j = _json(reply);
    if (j == null) throw Exception('WYRD couldn\'t read that photo just now — try again');
    int n(Object? v) => v is num ? v.round() : int.tryParse('$v'.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    List<String> l(Object? v) => v is List ? [for (final x in v) _clip('$x', 140)].where((s) => s.isNotEmpty).toList() : [];
    return jsonEncode({
      'title': _clip(j['title'] as String?, 80),
      'description': _clip(j['description'] as String?, 700),
      'category': _clip(j['category'] as String?, 40),
      'condition': _clip(j['condition'] as String?, 20),
      'priceLow': n(j['priceLow']),
      'priceHigh': n(j['priceHigh']),
      'suggestedPrice': n(j['suggestedPrice']),
      'tags': l(j['tags']).take(5).toList(),
      'allowed': j['allowed'] != false,
      'warnings': l(j['warnings']).take(5).toList(),
    });
  }

  /// Reads a bank-transfer screenshot against what the order expects, for the admin, as JSON:
  /// {verdict: "looks_ok"|"check_carefully"|"likely_fake", amount, bank, recipientName,
  /// recipientAccount, reference, date, status, reasons[]}. It never confirms a payment -- only the
  /// bank statement can; it says where to look.
  static Future<String> checkReceipt(Session session, String imageBase64Jpeg, {int? expectedAmount, String? expectedAccount}) async {
    _checkImage(imageBase64Jpeg);
    final system = 'You help the admin of Konnectly, a Nigerian campus marketplace, check bank-transfer screenshots '
        'that buyers upload as proof of payment. Buyers pay by transfer to Konnectly\'s account; fake or edited '
        'receipts are a known scam. Read the screenshot and compare it with what the order expects. Look for: amount '
        'mismatch; wrong recipient account or name; status pending/failed/reversed rather than successful; date far '
        'from today; signs of editing (misaligned or mismatched fonts, uneven spacing, odd colours, cropped status '
        'bars, digits that don\'t line up); a screenshot of a transfer "form" rather than a completed receipt. Be '
        'honest about what can\'t be judged from an image. Never say a payment is confirmed: only the bank statement '
        'can confirm it.\nReply with ONLY a JSON object: {"verdict": "looks_ok" | "check_carefully" | "likely_fake", '
        '"amount": integer naira or null, "bank": string or null, "recipientName": string or null, '
        '"recipientAccount": string or null, "reference": string or null, "date": string or null, "status": string or '
        'null, "reasons": array of short strings explaining the verdict}';
    final today = DateTime.now().toUtc().add(const Duration(hours: 1)).toIso8601String().substring(0, 10);
    final user = [
      'Today in Lagos: $today.',
      if (expectedAmount != null && expectedAmount > 0) 'The order total the buyer should have sent: N$expectedAmount.',
      if ((expectedAccount ?? '').trim().isNotEmpty) 'Konnectly\'s receiving account: ${_clip(expectedAccount, 120)}.',
      'Check this receipt.',
    ].join('\n');
    final reply = await LlmService.callWithImage(session, system, imageBase64Jpeg, user, 600);
    final j = _json(reply);
    if (j == null) throw Exception('WYRD couldn\'t read that screenshot just now — try again');
    String? s(Object? v) => v == null || '$v'.trim().isEmpty || '$v' == 'null' ? null : _clip('$v', 120);
    final verdict = const {'looks_ok', 'check_carefully', 'likely_fake'}.contains(j['verdict']) ? j['verdict'] : 'check_carefully';
    final amount = j['amount'] is num ? (j['amount'] as num).round() : int.tryParse('${j['amount']}'.replaceAll(RegExp(r'[^0-9]'), ''));
    return jsonEncode({
      'verdict': verdict,
      'amount': amount,
      'bank': s(j['bank']),
      'recipientName': s(j['recipientName']),
      'recipientAccount': s(j['recipientAccount']),
      'reference': s(j['reference']),
      'date': s(j['date']),
      'status': s(j['status']),
      'reasons': j['reasons'] is List ? [for (final r in j['reasons'] as List) _clip('$r', 200)].take(6).toList() : <String>[],
    });
  }
}
