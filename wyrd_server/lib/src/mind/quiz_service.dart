import 'dart:math';

import '../generated/protocol.dart';
import 'library_knowledge.dart';
import 'package:serverpod/serverpod.dart';

/// A word worth testing, with the kind of word it is (so wrong answers look like right ones).
class _Key {
  _Key(this.word, this.kind, this.score);
  final String word;
  final String kind; // 'num', 'name' or 'term'
  double score;
}

/// Quiz me: questions made from the passage a student just read -- no AI. It picks the words
/// that carry the passage (terms it repeats, names, figures), blanks them out of the sentences
/// they appear in, and offers wrong answers of the same kind taken from the passage itself (or,
/// when the passage runs short, words WordNet files under the same idea). One true-or-false
/// question checks a whole statement. Words someone missed before come back first.
class QuizService {
  static const _questions = 5;

  static const _stop = {
    'about', 'above', 'after', 'again', 'against', 'along', 'already', 'although', 'always', 'among', 'another', 'anything',
    'around', 'because', 'become', 'becomes', 'before', 'being', 'below', 'between', 'beyond', 'cannot', 'could', 'during',
    'either', 'enough', 'every', 'everything', 'first', 'following', 'found', 'further', 'given', 'great', 'however', 'indeed',
    'itself', 'large', 'little', 'might', 'moment', 'myself', 'never', 'nothing', 'often', 'other', 'others', 'otherwise',
    'perhaps', 'rather', 'really', 'second', 'seemed', 'several', 'should', 'shall', 'since', 'small', 'something', 'still',
    'their', 'themselves', 'there', 'therefore', 'these', 'thing', 'things', 'those', 'though', 'three', 'through', 'together',
    'towards', 'under', 'until', 'upon', 'usually', 'which', 'while', 'whole', 'whose', 'within', 'without', 'would', 'yourself',
    'having', 'where', 'whether', 'himself', 'herself', 'thought', 'called', 'example', 'section', 'figure',
    'chapter', 'objectives', 'learning', 'able', 'will', 'said', 'replied', 'answered', 'cried', 'asked',
  };

  static String _plain(String passage) => passage
      .split('\n')
      .where((l) => !l.startsWith('## '))
      .join('\n')
      .replaceAll('_', '')
      .replaceAll('•', '');

  /// Words that carry [text], best first.
  static List<_Key> _keys(String text, Set<String> missed) {
    final freq = <String, int>{};
    final shape = <String, (String, String)>{}; // lower -> (as written, kind)
    for (final m in RegExp(r"(?<=^|[\s(“\x22'])([A-Za-z][A-Za-z\-']{2,}[A-Za-z]|\d+(?:[.,]\d+)?)").allMatches(text)) {
      final w = m.group(1)!;
      final lower = w.toLowerCase();
      if (_stop.contains(lower)) continue;
      final start = m.start;
      final before = text.substring(max(0, start - 3), start);
      final sentenceStart = start == 0 || RegExp(r'[.!?“\x22]\s*$|\n\s*$').hasMatch(before);
      final kind = RegExp(r'^\d').hasMatch(w)
          ? 'num'
          : (w[0] == w[0].toUpperCase() && !sentenceStart)
              ? 'name'
              : (w[0] == w[0].toLowerCase() && w.length >= 6)
                  ? 'term'
                  : null;
      if (kind == null) continue;
      if (kind == 'num' && (w.length < 2 || w == '10' && freq.isEmpty)) continue;
      freq[lower] = (freq[lower] ?? 0) + 1;
      shape.putIfAbsent(lower, () => (w, kind));
    }
    final out = <_Key>[];
    freq.forEach((lower, n) {
      final (w, kind) = shape[lower]!;
      var score = n + w.length / 8 + (kind == 'name' ? 0.8 : kind == 'num' ? 0.6 : 0);
      if (missed.contains(lower)) score += 5; // missed last time: ask again
      out.add(_Key(w, kind, score));
    });
    out.sort((a, b) => b.score.compareTo(a.score));
    return out;
  }

  /// Wrong answers that look like [key]: the same kind of word, from the passage first.
  static Future<List<String>> _distractors(Session session, _Key key, List<_Key> all, Random rand) async {
    final lower = key.word.toLowerCase();
    if (key.kind == 'num') {
      final n = double.tryParse(key.word.replaceAll(',', ''));
      if (n == null) return [];
      final decimals = key.word.contains('.') ? key.word.split('.').last.length : 0;
      String f(double x) => decimals > 0 ? x.toStringAsFixed(decimals) : x.round().toString();
      final fromText = all.where((k) => k.kind == 'num' && k.word != key.word).map((k) => k.word);
      final made = {for (final m in [2.0, 0.5, 10.0, 1.5, 3.0]) f(n * m), f(n + 1), f(max(0, n - 1))}..remove(key.word);
      return {...fromText, ...made}.where((x) => x != key.word).take(6).toList()..shuffle(rand);
    }
    final same = all
        .where((k) => k.kind == key.kind && k.word.toLowerCase() != lower && !k.word.toLowerCase().contains(lower) && !lower.contains(k.word.toLowerCase()))
        .toList()
      ..sort((a, b) => (a.word.length - key.word.length).abs().compareTo((b.word.length - key.word.length).abs()));
    final out = same.take(6).map((k) => k.word).toList();
    if (out.length < 3 && key.kind == 'term') {
      // WordNet: other words filed under the same idea ("gravity" -> other physical phenomena)
      final rows = await session.db.unsafeQuery(
        'SELECT DISTINCT s2."lemma" FROM "word_sense" s1 JOIN "word_sense" s2 ON s2."hypernym" = s1."hypernym" '
        'WHERE s1."lemma" = @w AND s1."hypernym" IS NOT NULL AND s2."lemma" <> @w AND s2."lemma" NOT LIKE \'%\\_%\' LIMIT 12',
        parameters: QueryParameters.named({'w': lower}),
      );
      out.addAll(rows.map((r) => r[0] as String).where((x) => !out.contains(x)));
    }
    return out..shuffle(rand);
  }

  /// A round of questions from [passage]. [missed] are words this person got wrong before.
  static Future<List<QuizQuestion>> make(Session session, String passage, {Set<String> missed = const {}, int? seed}) async {
    final text = _plain(passage);
    final sentences = LibraryKnowledge.sentences(text).where((s) => s.length >= 40 && s.length <= 280).toList();
    if (sentences.length < 2) return [];
    final rand = Random(seed ?? DateTime.now().millisecondsSinceEpoch);
    final keys = _keys(text, missed.map((m) => m.toLowerCase()).toSet());
    final used = <int>{};
    final questions = <QuizQuestion>[];

    // fill in the blank
    for (final key in keys.take(24)) {
      if (questions.length >= _questions - 1) break;
      final pattern = RegExp('(?<![A-Za-z0-9])${RegExp.escape(key.word)}(?![A-Za-z0-9])');
      final i = sentences.indexWhere((s) => pattern.hasMatch(s));
      if (i < 0 || used.contains(i)) continue;
      final wrong = await _distractors(session, key, keys, rand);
      if (wrong.length < 3) continue;
      used.add(i);
      final options = [key.word, ...wrong.take(3)]..shuffle(rand);
      questions.add(QuizQuestion(
        kind: 'cloze',
        prompt: sentences[i].replaceFirst(pattern, '_____'),
        options: options,
        answer: options.indexOf(key.word),
        explanation: sentences[i],
        keyword: key.word,
      ));
    }

    // true or false: a sentence as written, or with one word swapped for a look-alike
    for (var i = 0; i < sentences.length && questions.length < _questions; i++) {
      final j = (i * 7 + rand.nextInt(sentences.length)) % sentences.length;
      if (used.contains(j)) continue;
      final s = sentences[j];
      final inSentence = keys.where((k) => RegExp('(?<![A-Za-z0-9])${RegExp.escape(k.word)}(?![A-Za-z0-9])').hasMatch(s)).toList();
      if (inSentence.isEmpty) continue;
      used.add(j);
      final key = inSentence.first;
      final makeFalse = rand.nextBool();
      var statement = s;
      if (makeFalse) {
        final wrong = await _distractors(session, key, keys, rand);
        final swap = wrong.where((w) => !s.toLowerCase().contains(w.toLowerCase())).firstOrNull; // a word the sentence doesn't already use
        if (swap == null) continue;
        statement = s.replaceFirst(RegExp('(?<![A-Za-z0-9])${RegExp.escape(key.word)}(?![A-Za-z0-9])'), swap);
      }
      questions.add(QuizQuestion(
        kind: 'truefalse',
        prompt: statement,
        options: const ['True', 'False'],
        answer: makeFalse ? 1 : 0,
        explanation: s,
        keyword: key.word,
      ));
    }
    // in the order the passage tells it
    questions.sort((a, b) => sentences.indexOf(a.explanation).compareTo(sentences.indexOf(b.explanation)));
    return questions;
  }

  /// Words this person missed in recent rounds on [readingItemId] (or anywhere, when null).
  static Future<Set<String>> missed(Session session, UuidValue authUserId, int? readingItemId) async {
    final rows = await QuizAttempt.db.find(
      session,
      where: (t) => t.authUserId.equals(authUserId) & (readingItemId == null ? Constant.bool(true) : t.readingItemId.equals(readingItemId)),
      orderBy: (t) => t.at.desc(),
      limit: 5,
    );
    return {for (final r in rows) ...r.missed};
  }

  static Future<QuizStats> stats(Session session, UuidValue authUserId) async {
    final rows = await session.db.unsafeQuery(
      'SELECT count(*)::int, coalesce(sum("correct"), 0)::int, coalesce(sum("total"), 0)::int FROM "quiz_attempt" WHERE "authUserId" = @u::uuid',
      parameters: QueryParameters.named({'u': authUserId.uuid}),
    );
    final r = rows.first;
    return QuizStats(rounds: r[0] as int, correct: r[1] as int, total: r[2] as int);
  }
}
