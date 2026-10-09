/// Konnectly customer care without the AI: every question is matched to one of the topics below and
/// answered with a written reply taken from Konnectly's published terms, fees and refund policy
/// (5 October 2026). Costs nothing per message.
///
/// Matching: the question is lower-cased, Pidgin and slang mapped to plain words, and each word cut
/// to a rough stem; each topic scores the cue words and phrases it finds (one typo allowed in long
/// words). A short follow-up ("how long?", "and if he refuses?") leans on the previous topic. Anything
/// unmatched, or that needs an order looked up, goes to a person on WhatsApp.
class KonnectlyCare {
  static const whatsapp = '0810 487 0034';

  static final _topics = <_Topic>[
    _Topic('greeting', cues: ['hi', 'hello', 'hey', 'good morning', 'good afternoon', 'good evening', 'how far', 'sup'],
        weak: true,
        reply: 'Hi! I\'m WYRD, Konnectly\'s care assistant. I can help with buying, selling, fees, delivery, refunds and your '
            'account. What do you need?',
        next: ['How do I buy something?', 'What fees will I pay?', 'How do refunds work?', 'How do I start selling?']),
    _Topic('thanks', cues: ['thank', 'thanks', 'thx', 'ok', 'okay', 'alright', 'great', 'bye', 'cool', 'nice'],
        weak: true, reply: 'You\'re welcome! If anything else comes up, just ask.', next: ['How do refunds work?', 'Talk to a person']),
    _Topic('about', cues: ['what is konnectly', 'about konnectly', 'who own', 'who run', 'who create', 'is konnectly legit', 'legit', 'trust konnectly'],
        reply: 'Konnectly is a marketplace for Nigerian campuses: students and nearby vendors sell, students buy, around '
            'about 270 schools. Items are sold by independent sellers, not by Konnectly. Your payment goes to Konnectly first '
            'and the seller is only paid after delivery is confirmed, which is what keeps buyers safe. It\'s run by Emmanuel '
            'Daniel Prince in Lagos.',
        next: ['How do I buy something?', 'How do I start selling?', 'Is my money safe?']),
    _Topic('fees', cues: ['fee', 'charge', 'cost', 'service fee', 'site fee', 'how much', 'extra money', 'commission', 'free'],
        reply: 'Listing is free, and so is signing up. When you buy, checkout adds a service fee of ₦300 per item and a site '
            'fee of ₦500 per item, and the site fee is waived on your first 2 payments. You always see the full total '
            'before you pay.',
        next: ['How do I pay?', 'How do refunds work?']),
    _Topic('buy', cues: ['how buy', 'how to buy', 'how order', 'place order', 'checkout', 'add to cart', 'cart', 'purchase', 'buy something'],
        reply: 'Add what you want to your cart, choose your meetup spot on the map, then check out. You pay by bank transfer to '
            'the Konnectly account shown at checkout and tap "I\'ve paid". Once Konnectly confirms your payment, the seller '
            'gets your order, hands it over at your spot, and you confirm receipt and rate them.',
        next: ['What fees will I pay?', 'How long does payment confirmation take?', 'How does delivery work?']),
    _Topic('pay_method', cues: ['card', 'paystack', 'pay with card', 'ussd', 'pos', 'payment method', 'how pay', 'how to pay', 'transfer', 'opay', 'bank transfer'],
        reply: 'Right now you pay by bank transfer to the Konnectly account shown at checkout, then tap "I\'ve paid". Card '
            'payment (Paystack) is currently unavailable. Only pay to the account checkout shows you, never to a number someone '
            'sends you.',
        next: ['How long does payment confirmation take?', 'A seller wants me to pay directly']),
    _Topic('pay_pending', cues: ['paid but', 'not confirm', 'payment not', 'still pending', 'pending', 'confirm my payment', 'how long confirm', 'payment confirmation', 'waiting payment', 'i have paid', 'i don pay', 'i paid'],
        reply: 'After you tap "I\'ve paid", Konnectly checks that the transfer arrived and confirms it, and you\'re notified as '
            'soon as it\'s done; the seller only sees your order after that. If it\'s taking long, message customer care on '
            'WhatsApp $whatsapp with your order code and the transfer receipt and they\'ll check it for you. If the transfer '
            'never arrived, the order is cancelled and nothing is charged.',
        handoff: true, next: ['What if the order can\'t go ahead?', 'Talk to a person']),
    _Topic('pay_direct', cues: ['pay directly', 'pay seller', 'pay him', 'pay her', 'outside konnectly', 'outside the app', 'send money to seller', 'his account', 'her account', 'seller account', 'pay me directly', 'direct transfer'],
        reply: 'Please don\'t. Pay only through Konnectly checkout. Money sent straight to a seller isn\'t covered by '
            'Konnectly\'s payment checks or refunds, and asking buyers to pay outside Konnectly is against the rules. If a '
            'seller is pushing you to, report them to customer care on WhatsApp $whatsapp.',
        next: ['How do I report someone?', 'How do I pay?']),
    _Topic('secrets', cues: ['otp', 'pin', 'password', 'bvn', 'card details', 'cvv', 'token', 'code sent to my phone', 'asked for my'],
        reply: 'Never share your password, PIN, OTP, card details or BVN with anyone, including someone who says they\'re from '
            'Konnectly. Konnectly will never ask for them in chat. If someone has, stop replying and report it to customer '
            'care on WhatsApp $whatsapp.',
        next: ['How do I report someone?', 'Is my money safe?']),
    _Topic('safe', cues: ['is my money safe', 'money safe', 'scam', 'fraud', 'trust', 'safe to buy', 'secure', 'fake seller', 'scammer'],
        reply: 'Your money is safest inside checkout: you pay Konnectly, the seller only sees your order once your payment is '
            'confirmed, and they\'re only paid after delivery is confirmed. If something goes wrong, the refund policy covers '
            'you. Look for the gold Verified tag and ratings on a seller\'s shop, and never pay anyone outside Konnectly.',
        next: ['How do refunds work?', 'A seller wants me to pay directly', 'How do I report someone?']),
    _Topic('refunds', cues: ['refund', 'money back', 'get my money', 'return my money', 'reimburse'],
        reply: 'You get a full refund, fees included, if the order is cancelled before handover, if the seller doesn\'t deliver '
            'in the agreed time, or if the item is wrong or clearly not as described. Contact customer care within 48 hours '
            'of the handover with your order code and photos of the problem. They check with the seller and reply within 2 '
            'working days, and approved refunds reach the account you paid from within 5 working days.',
        next: ['The item is not as described', 'The seller didn\'t deliver', 'Can I return it if I change my mind?']),
    _Topic('refund_time', cues: ['how long refund', 'when refund', 'refund take', 'refund time', 'how many days'],
        reply: 'Customer care replies within 2 working days of your claim, and an approved refund is sent to the account you '
            'paid from within 5 working days. Claims must come within 48 hours of the handover.',
        next: ['Talk to a person']),
    _Topic('not_described', cues: ['wrong item', 'not as described', 'damaged', 'broken', 'fake item', 'different model', 'missing part', 'spoil', 'not what i order', 'not working', 'faulty'],
        reply: 'That\'s covered. Within 48 hours of the handover, send customer care on WhatsApp $whatsapp your order code and '
            'clear photos of the problem. They\'ll check with the seller and reply within 2 working days; if approved you get '
            'everything back, fees included, within 5 working days.',
        handoff: true, next: ['Talk to a person']),
    _Topic('not_delivered', cues: ['didnt deliver', 'not deliver', 'never deliver', 'no show', 'seller not respond', 'seller not answer', 'seller disappear', 'seller not reply', 'havent receive', 'not receive', 'never came', 'show up', 'didnt come', 'didnt show'],
        reply: 'If the seller doesn\'t deliver within the agreed time, you\'re entitled to a full refund, fees included. Send '
            'customer care on WhatsApp $whatsapp your order code and they\'ll sort it out with the seller.',
        handoff: true, next: ['How long do refunds take?', 'Talk to a person']),
    _Topic('change_mind', cues: ['change my mind', 'changed my mind', 'dont want', 'return', 'return it', 'return the item', 'no longer want', 'swap'],
        reply: 'Before the handover you can cancel and get everything back. After a handover you accepted, change of mind '
            'usually isn\'t refundable unless the seller agrees, so check the item at the meetup before you confirm.',
        next: ['How do I cancel an order?', 'How do refunds work?']),
    _Topic('cancel', cues: ['cancel', 'cancel order', 'stop the order'],
        reply: 'An order cancelled before the handover, by you, the seller or Konnectly, is refunded in full, fees included. '
            'To cancel, message customer care on WhatsApp $whatsapp with your order code.',
        handoff: true, next: ['How long do refunds take?']),
    _Topic('delivery', cues: ['deliver', 'delivery', 'meetup', 'meet up', 'pickup', 'pick up', 'handover', 'where meet', 'location', 'drop off', 'hostel'],
        reply: 'Standard delivery is a handover at the meetup spot you pick on the map at checkout, like your hostel or the '
            'main gate. The seller confirms the handover, then you confirm you received it and rate the order. Check the item '
            'before you confirm.',
        next: ['The seller didn\'t deliver', 'Can I return it if I change my mind?']),
    _Topic('sell', cues: ['how sell', 'how to sell', 'start selling', 'list item', 'post item', 'upload item', 'become seller', 'sell something', 'open shop', 'my shop', 'listing', 'can i sell'],
        reply: 'Sign up free, pick your school, and tap to add an item: up to 4 photos (the first is your cover), a title, '
            'price and description. Listing costs nothing. Add your bank details so you can be paid, and a photo and short bio '
            'so buyers trust your shop. Only list things you own, described honestly, at a price you\'ll honour.',
        next: ['When do sellers get paid?', 'What can\'t I sell?', 'How do I get the Verified tag?']),
    _Topic('payout', cues: ['seller paid', 'get paid', 'when paid', 'payout', 'my money as seller', 'withdraw', 'earnings', 'when will i receive my money', 'account number', 'bank details'],
        reply: 'Sellers are paid after delivery is confirmed: you confirm the handover, the buyer confirms receipt, and '
            'Konnectly sends the money to the bank account in your payout details. Add your bank, 10-digit account number and '
            'account name in your profile. They\'re private to you and the Konnectly team.',
        next: ['How do I start selling?', 'Talk to a person']),
    _Topic('banned', cues: ['cant sell', 'what cant i sell', 'not allowed', 'allowed to sell', 'banned', 'prohibited'],
        strong: ['weapon', 'gun', 'knife', 'drug', 'weed', 'alcohol', 'beer', 'cigarette', 'vape', 'tobacco', 'exam question', 'expo', 'animal', 'pet', 'counterfeit', 'stolen'],
        reply: 'Not allowed on Konnectly: anything illegal, stolen or counterfeit; weapons; drugs; alcohol or tobacco; exam '
            'questions or academic cheating services; adult content; live animals; financial products; or anything dangerous. '
            'Listings like these are removed and the account can be suspended.',
        next: ['How do I start selling?']),
    _Topic('vendor', cues: ['vendor', 'outside vendor', 'business', 'graduate', 'shop owner'], strong: ['not a student', 'non student'],
        reply: 'Yes. Open a vendor shop, choose the school near you, and your items show in that school\'s marketplace with a '
            'Vendor tag. Vendors must be 18 or older, and can verify with NIN or BVN for the gold Verified tag.',
        next: ['How do I get the Verified tag?', 'When do sellers get paid?']),
    _Topic('verified', cues: ['verified', 'verify', 'gold tag', 'badge', 'nin', 'kyc', 'verification'],
        reply: 'Sellers can earn the gold Verified tag by verifying with their NIN or BVN in the app. It\'s used only to confirm '
            'who you are and is never shown publicly. Tags and sales badges come from real ID checks and confirmed sales, and '
            'can be removed if abused.',
        next: ['How do I start selling?', 'Is my data private?']),
    _Topic('age', cues: ['age', 'how old', 'under 18', 'minor', '16', '17'],
        reply: 'You must be at least 16 to use Konnectly, with a parent or guardian\'s permission if you\'re under 18. Outside '
            'vendors must be 18 or older.',
        next: ['Can I sell if I\'m not a student?']),
    _Topic('account', cues: ['sign up', 'signup', 'register', 'create account', 'log in', 'login', 'cant login', 'forgot password', 'reset password', 'change school', 'account'],
        reply: 'Signing up is free: pick Student or Outside vendor, your school, and an email and password. Forgot your '
            'password? Tap "Forgot password?" on the sign-in screen and a reset link goes to your email. Keep one account per '
            'person and never share your password.',
        next: ['How do I delete my account?', 'Talk to a person']),
    _Topic('delete', cues: ['delete account', 'delete my account', 'close account', 'remove my account', 'download my data', 'my data'],
        reply: 'In Privacy settings you can download your data or delete your account. Deleting removes your account, shop, '
            'listings and saved details; order records are kept for disputes and accounting.',
        next: ['Is my data private?']),
    _Topic('privacy', cues: ['privacy', 'private', 'data', 'who can see', 'my number', 'phone number', 'location', 'tracking', 'ads'],
        reply: 'Konnectly follows the Nigeria Data Protection Act. No ads, no tracking, and your data is never sold. A seller sees '
            'your name, phone and meetup spot only after your payment is confirmed; payout and ID details are private to you '
            'and the Konnectly team. Online status and live location are optional and can be switched off in Privacy '
            'settings.',
        next: ['How do I delete my account?']),
    _Topic('ratings', cues: ['rating', 'rate', 'review', 'stars', 'feedback'],
        reply: 'After a completed order, the buyer confirms receipt and can rate the seller. Only the buyer of a completed order '
            'can rate it, and fake, paid or misleading ratings are removed.',
        next: ['How does delivery work?']),
    _Topic('install', cues: ['install', 'download app', 'play store', 'app store', 'apk', 'home screen', 'iphone', 'android', 'app'],
        reply: 'There\'s no app store download: Konnectly installs from the browser in under a minute. On Android, open '
            'konnectly.xyz in Chrome and choose "Install" or "Add to Home screen" from the menu. On iPhone, open it in Safari, '
            'tap the Share button and choose "Add to Home Screen". It also works fine in the browser.',
        next: ['Talk to a person']),
    _Topic('photos', cues: ['photo', 'picture', 'image', 'heic', 'how many photos', 'pictures'],
        reply: 'You can add up to 4 photos per listing, and the first one is your cover. Any photo works, including iPhone HEIC '
            'and screenshots; Konnectly resizes them for you. Only upload photos you took or have permission to use.',
        next: ['How do I start selling?']),
    _Topic('report', cues: ['report', 'harass', 'impersonat', 'abuse', 'suspicious', 'complain', 'complaint'],
        reply: 'Report it to customer care on WhatsApp $whatsapp with the person\'s shop name, the order code if there is one, '
            'and screenshots. Scams, harassment, impersonation and asking people to pay outside Konnectly lead to removed '
            'listings and suspended accounts.',
        handoff: true, next: ['Is my money safe?']),
    _Topic('order_status', cues: ['where my order', 'where is my order', 'order status', 'track', 'my order', 'order code', 'when will my order', 'still waiting'],
        reply: 'I can\'t see individual orders from here. Your order\'s live status is in the app under your orders, and if '
            'something looks stuck, message customer care on WhatsApp $whatsapp with your order code.',
        handoff: true, next: ['How long does payment confirmation take?', 'The seller didn\'t deliver']),
    _Topic('human', cues: ['talk to a person', 'talk to someone', 'speak to', 'someone', 'real person', 'human', 'agent', 'customer care', 'customer service', 'contact', 'call', 'phone number of konnectly', 'whatsapp', 'email', 'support', 'help me'],
        reply: 'You can reach Konnectly customer care on WhatsApp $whatsapp or by email at emmanueldanielprince837@gmail.com. '
            'Have your order code ready if it\'s about an order.',
        handoff: true, next: []),
  ];

  /// A short "how long?" / "when?" asks about the timing of whatever was just discussed: which
  /// topic answers it, by the previous topic. After anything else it isn't guessed at.
  static const _timing = {
    'refunds': 'refund_time', 'refund_time': 'refund_time', 'not_described': 'refund_time', 'not_delivered': 'refund_time',
    'cancel': 'refund_time', 'change_mind': 'refund_time',
    'buy': 'pay_pending', 'pay_method': 'pay_pending', 'pay_pending': 'pay_pending',
    'sell': 'payout', 'payout': 'payout', 'vendor': 'payout',
  };
  static final _timingWords = RegExp(r'\b(how long|when|how many days|how soon)\b');

  static final _slang = <RegExp, String>{
    RegExp(r'\bwetin\b'): 'what',
    RegExp(r'\babeg\b|\bpls\b|\bplz\b|\bplease\b'): '',
    RegExp(r'\bdey\b'): 'is',
    RegExp(r'\bwan\b'): 'want',
    RegExp(r'\bi no like\b|\bi no want\b'): 'i dont want',
    RegExp(r'\bam\b'): 'it',
    RegExp(r'\bdon\b'): 'have',
    RegExp(r'\bmake i\b'): 'should i',
    RegExp(r'\bhow i go\b|\bhow i fit\b|\bhow una\b'): 'how to',
    RegExp(r'\bmoni\b|\bowo\b'): 'money',
    RegExp(r'\bna\b'): 'is',
    RegExp(r'\bno be\b'): 'not',
    RegExp(r'\bu\b'): 'you',
    RegExp(r'\bur\b'): 'your',
    RegExp(r'\bmy guy\b|\bbro\b|\bsis\b'): '',
    RegExp(r"\bdidn'?t\b|\bdid not\b"): 'didnt',
    RegExp(r"\bhaven'?t\b|\bhave not\b"): 'havent',
    RegExp(r"\bcan'?t\b|\bcannot\b"): 'cant',
    RegExp(r"\bdon'?t\b|\bdo not\b"): 'dont',
    RegExp(r"\bisn'?t\b|\bis not\b"): 'not',
  };

  static String _normal(String s) {
    var t = ' ${s.toLowerCase().replaceAll('’', "'")} ';
    _slang.forEach((re, to) => t = t.replaceAll(re, to));
    return t.replaceAll(RegExp(r"[^a-z0-9' ]"), ' ').replaceAll("'", '').replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String _stem(String w) {
    if (w.length > 5 && w.endsWith('ing')) return w.substring(0, w.length - 3);
    if (w.length > 4 && w.endsWith('ed')) return w.substring(0, w.length - 2);
    if (w.length > 4 && RegExp(r'(ss|x|z|ch|sh)es$').hasMatch(w)) return w.substring(0, w.length - 2);
    if (w.length > 3 && w.endsWith('s') && !w.endsWith('ss')) return w.substring(0, w.length - 1);
    return w;
  }

  static bool _near(String a, String b) {
    if (a == b) return true;
    if (a.length < 5 || b.length < 5 || (a.length - b.length).abs() > 1) return false;
    // one edit apart
    var i = 0, j = 0, edits = 0;
    while (i < a.length && j < b.length) {
      if (a[i] == b[j]) {
        i++;
        j++;
        continue;
      }
      if (++edits > 1) return false;
      if (a.length > b.length) {
        i++;
      } else if (b.length > a.length) {
        j++;
      } else {
        i++;
        j++;
      }
    }
    return edits + (a.length - i) + (b.length - j) <= 1;
  }

  /// How well [words] (stems) match a cue: a phrase must appear in order (gaps allowed); scored by length.
  static double _cueScore(List<String> words, String cue) {
    final parts = cue.split(' ').map(_stem).toList();
    var at = 0;
    for (final p in parts) {
      var found = false;
      while (at < words.length) {
        if (_near(words[at++], p)) {
          found = true;
          break;
        }
      }
      if (!found) return 0;
    }
    return parts.length == 1 ? 1 : 1.0 + parts.length; // phrases count for much more than single words
  }

  static ({_Topic? topic, double score}) _best(String text) {
    final words = _normal(text).split(' ').where((w) => w.isNotEmpty).map(_stem).toList();
    _Topic? best;
    var top = 0.0;
    for (final t in _topics) {
      var s = 0.0;
      for (final c in t.cues) {
        s += _cueScore(words, c);
      }
      for (final c in t.strong) {
        s += 6 * _cueScore(words, c);
      }
      if (t.weak && words.length > 4) s *= 0.3; // "hi, my order never came" is about the order
      if (s > top) {
        top = s;
        best = t;
      }
    }
    return (topic: best, score: top);
  }

  /// The reply to [message] as {reply, suggestions[], handoff, topic}; [lastTopic] is the topic of the
  /// previous reply in this conversation, if any.
  static Map<String, Object?> answer(String message, {String? lastTopic}) {
    var m = _best(message);
    final norm = _normal(message);
    // a short follow-up leans on the conversation so far
    final follow = _timing[lastTopic];
    if (m.score < 2 && follow != null && norm.split(' ').length <= 6 && _timingWords.hasMatch(norm)) {
      m = (topic: _topics.firstWhere((t) => t.id == follow), score: 2);
    }
    final t = m.topic;
    if (t == null || m.score < 1) {
      return {
        'reply': 'I\'m not sure I\'ve understood that one. I can help with buying, paying, fees, delivery, refunds, selling, '
            'payouts and your account. For anything else, Konnectly customer care is on WhatsApp $whatsapp.',
        'suggestions': ['How do I buy something?', 'How do refunds work?', 'How do I start selling?', 'Talk to a person'],
        'handoff': true,
        'topic': null,
      };
    }
    return {'reply': t.reply, 'suggestions': t.next, 'handoff': t.handoff, 'topic': t.id};
  }
}

class _Topic {
  _Topic(this.id, {required this.cues, this.strong = const [], required this.reply, this.next = const [], this.handoff = false, this.weak = false});
  final String id;
  final List<String> cues;

  /// Cue words that settle the topic on their own (a banned item named outright).
  final List<String> strong;
  final String reply;
  final List<String> next;

  /// Its reply points to a person on WhatsApp (shown as a button on the page).
  final bool handoff;

  /// Small talk: loses to any real topic in a longer message.
  final bool weak;
}
