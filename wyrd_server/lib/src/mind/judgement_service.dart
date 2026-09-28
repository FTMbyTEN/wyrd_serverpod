import 'topic_service.dart';

/// The gate's decision about one reply.
class Judgement {
  Judgement({required this.verdict, required this.reasons, required this.text});

  /// 'pass', 'softened', 'corrected' or 'blocked'.
  final String verdict;
  final List<String> reasons;

  /// The reply as it should actually go out.
  final String text;

  bool get passed => verdict == 'pass';

  /// Stored on the conversation turn, e.g. "softened: specifics nothing backs up".
  String get summary => passed ? 'pass' : '$verdict: ${reasons.join('; ')}';
}

/// Filter + judgement: the last stage before a reply reaches a person. It checks the reply the
/// way a careful editor would -- with what WYRD already has, and no extra AI call:
///  - **safe?** secrets (API keys, tokens, private keys) and other people's email addresses never
///    leave: the reply is blocked and replaced;
///  - **honest about actions?** "I've queued the flight" / "I opened the map" with no such action
///    taken gets a correction appended;
///  - **grounded, confident and specific?** a factual answer full of precise figures, dates or
///    names that nothing WYRD knows or read backs up -- or backed only by sources it has learned
///    to doubt -- gets an honest "worth double-checking" line, and isn't learned as an answer.
class JudgementService {
  static final _secret = RegExp(
    r'(sk-ant-[A-Za-z0-9_\-]{10,}|sk-[A-Za-z0-9]{20,}|pa-[A-Za-z0-9_\-]{20,}|AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----|\bBearer\s+[A-Za-z0-9._\-]{20,}|eyJ[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,}\.[A-Za-z0-9_\-]{10,})',
  );
  static final _email = RegExp(r'\b[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}\b');
  static final _hedged = RegExp(
    r"\b(i think|i believe|probably|possibly|perhaps|maybe|not (sure|certain)|i'?m unsure|if i recall|roughly|about|around|approximately|i don'?t know)\b",
    caseSensitive: false,
  );
  // precise figures: decimals (5.2), multi-digit numbers and years, percentages, money
  static final _numberish = RegExp(r'\b\d+[.,]\d+\b|\b\d{2,}\b|\b\d+(?:\.\d+)?\s?%|\$\s?\d');
  static final _properName = RegExp(r'(?<![.!?]\s)(?<!^)\b[A-Z][a-z]+(?:\s+[A-Z][a-z]+)+\b');
  static final _droneClaim = RegExp(
    r"\b(i'?ve|i have) (queued|planned|started|launched|scheduled|sent) (the|a|your) (flight|mission)\b|\bthe drone is (now )?(flying|taking off|airborne|on its way)\b",
    caseSensitive: false,
  );
  static final _mapClaim = RegExp(r"\b(i'?ve|i have) (opened|brought up|pulled up) (the|a) (map|globe)\b", caseSensitive: false);

  static const _unverifiedNote = "I'm not certain of the specifics here, so they're worth double-checking.";

  /// Judges [reply] to [question].
  ///  - [context]: what WYRD knew going in (recalled memories, definitions, the conversation).
  ///  - [readWeb]: it read pages or books while answering, so its specifics have a source.
  ///  - [action]: the action actually taken, if any ('open_drone', 'open_world_map', ...).
  ///  - [askerEmail]: the person's own email, the only one a reply may contain.
  ///  - [groundingTrust]: average trust of the sources behind the recalled memories (Bias 2).
  ///  - [factual]: the question is a general, factual one (see LearnedAnswerService.isLearnable).
  static Judgement judge({
    required String reply,
    required String question,
    required String context,
    bool readWeb = false,
    String? action,
    String? askerEmail,
    double? groundingTrust,
    bool factual = false,
  }) {
    // 1. safety: nothing secret, nobody else's address
    if (_secret.hasMatch(reply)) {
      return Judgement(
        verdict: 'blocked',
        reasons: ['contained something that looks like a key or token'],
        text: "I started to include something that looked like a private key or token, so I've held that reply back. Ask me again another way?",
      );
    }
    final strangers = _email
        .allMatches(reply)
        .map((m) => m.group(0)!.toLowerCase())
        .where((e) => e != askerEmail?.toLowerCase() && !question.toLowerCase().contains(e))
        .toSet();
    if (strangers.isNotEmpty) {
      return Judgement(
        verdict: 'blocked',
        reasons: ["contained someone else's email address"],
        text: "My reply included someone else's contact details, so I've held it back — I don't share other people's information.",
      );
    }

    // 2. honesty about actions
    final corrections = <String>[];
    if (_droneClaim.hasMatch(reply) && action != 'open_drone') {
      corrections.add('No flight was actually queued. Ask again and I\'ll plan it properly.');
    }
    if (_mapClaim.hasMatch(reply) && action != 'open_world_map') {
      corrections.add("(I didn't actually open the map that time.)");
    }
    if (corrections.isNotEmpty) {
      return Judgement(
        verdict: 'corrected',
        reasons: ['claimed an action that did not happen'],
        text: '$reply\n\n${corrections.join(' ')}',
      );
    }

    // 3. grounded, confident, specific?
    if (factual && !readWeb) {
      final specifics = _numberish.allMatches(reply).length + _properName.allMatches(reply).length;
      final hedged = _hedged.hasMatch(reply);
      final ideas = TopicService.extractTopics(reply).where(TopicService.isIdea).toSet();
      final known = TopicService.extractTopics('$context $question').toSet();
      final support = ideas.isEmpty ? 1.0 : ideas.intersection(known).length / ideas.length;
      final reasons = <String>[];
      if (specifics >= 2 && support < 0.25 && !hedged) reasons.add('specifics nothing WYRD knows backs up');
      if (groundingTrust != null && groundingTrust < 0.35 && specifics >= 1 && !hedged) {
        reasons.add('drawn from sources WYRD has learned to doubt');
      }
      if (reasons.isNotEmpty) {
        return Judgement(verdict: 'softened', reasons: reasons, text: '$reply\n\n$_unverifiedNote');
      }
    }

    return Judgement(verdict: 'pass', reasons: const [], text: reply);
  }
}
