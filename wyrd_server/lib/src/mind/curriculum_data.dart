/// Mechanical port of server.js's CURRICULUM_SUBJECTS/CURRICULUM_LEVELS/CURRICULUM --
/// a fixed basic-to-advanced syllabus so WYRD's Wikipedia ingestion builds on a real
/// curriculum instead of picking articles at random.
class CurriculumEntry {
  final String subject;
  final String level;
  final String title;

  const CurriculumEntry(this.subject, this.level, this.title);
}

class CurriculumData {
  static const levels = ['basic', 'intermediate', 'advanced'];

  static const _subjects = <String, Map<String, List<String>>>{
    'Mathematics': {
      'basic': ['Arithmetic', 'Algebra', 'Euclidean geometry', 'Probability', 'Function (mathematics)'],
      'intermediate': ['Calculus', 'Linear algebra', 'Statistics', 'Number theory', 'Mathematical logic'],
      'advanced': ['Topology', 'Abstract algebra', 'Category theory', 'Chaos theory', "Gödel's incompleteness theorems"],
    },
    'Physics': {
      'basic': ['Force', 'Energy', "Newton's laws of motion", 'Electricity', 'Wave'],
      'intermediate': ['Thermodynamics', 'Electromagnetism', 'Special relativity', 'Optics', 'Nuclear physics'],
      'advanced': ['Quantum mechanics', 'General relativity', 'Quantum field theory', 'String theory', 'Standard Model'],
    },
    'Biology': {
      'basic': ['Cell (biology)', 'Photosynthesis', 'DNA', 'Evolution', 'Ecosystem'],
      'intermediate': ['Genetics', 'Natural selection', 'Cell biology', 'Microbiology', 'Human anatomy'],
      'advanced': ['Molecular biology', 'Epigenetics', 'Neuroscience', 'Immunology', 'Synthetic biology'],
    },
    'Chemistry': {
      'basic': ['Atom', 'Chemical element', 'Chemical reaction', 'Periodic table', 'Acid'],
      'intermediate': ['Organic chemistry', 'Chemical bond', 'Thermochemistry', 'Electrochemistry', 'Stoichiometry'],
      'advanced': ['Quantum chemistry', 'Biochemistry', 'Catalysis', 'Polymer chemistry', 'Spectroscopy'],
    },
    'Computer Science': {
      'basic': ['Computer', 'Algorithm', 'Programming language', 'Data structure', 'Internet'],
      'intermediate': ['Computational complexity theory', 'Database', 'Operating system', 'Computer network', 'Cryptography'],
      'advanced': ['Machine learning', 'Artificial intelligence', 'Distributed computing', 'Formal verification', 'Quantum computing'],
    },
    'History': {
      'basic': ['Ancient Egypt', 'Roman Empire', 'Middle Ages', 'Renaissance', 'Industrial Revolution'],
      'intermediate': ['French Revolution', 'World War I', 'World War II', 'Cold War', 'Colonialism'],
      'advanced': ['Historiography', 'Decolonization', 'Globalization', 'History of science', 'Economic history'],
    },
    'Philosophy': {
      'basic': ['Philosophy', 'Ethics', 'Logic', 'Epistemology', 'Metaphysics'],
      'intermediate': ['Existentialism', 'Utilitarianism', 'Stoicism', 'Social contract', 'Philosophy of mind'],
      'advanced': ['Phenomenology', 'Post-structuralism', 'Philosophy of language', 'Determinism', 'Ethics of artificial intelligence'],
    },
    'Economics': {
      'basic': ['Supply and demand', 'Market (economics)', 'Inflation', 'Gross domestic product', 'Trade'],
      'intermediate': ['Macroeconomics', 'Microeconomics', 'Monetary policy', 'Fiscal policy', 'Comparative advantage'],
      'advanced': ['Game theory', 'Behavioral economics', 'Econometrics', 'Monetary economics', 'Development economics'],
    },
    'Psychology': {
      'basic': ['Psychology', 'Cognition', 'Emotion', 'Memory', 'Behavior'],
      'intermediate': ['Cognitive psychology', 'Developmental psychology', 'Social psychology', 'Psychopathology', 'Behavioral neuroscience'],
      'advanced': ['Cognitive bias', 'Neuroplasticity', 'Psycholinguistics', 'Computational neuroscience', 'Theory of mind'],
    },
    'Environmental Science': {
      'basic': ['Climate', 'Ecology', 'Biodiversity', 'Pollution', 'Renewable energy'],
      'intermediate': ['Climate change', 'Sustainability', 'Conservation biology', 'Carbon cycle', 'Deforestation'],
      'advanced': ['Climate change mitigation', 'Planetary boundaries', 'Anthropocene', 'Ecosystem services', 'Environmental economics'],
    },
  };

  /// Breadth-first flattening: all subjects' basic titles, then all intermediate, then all
  /// advanced -- same order as Node's CURRICULUM.
  static final List<CurriculumEntry> entries = [
    for (final level in levels)
      for (final subjectEntry in _subjects.entries)
        for (final title in subjectEntry.value[level]!) CurriculumEntry(subjectEntry.key, level, title),
  ];
}
