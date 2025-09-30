import 'package:hive/hive.dart';

part 'mood_entry.g.dart';

/// Représente une entrée d'humeur de l'utilisateur
@HiveType(typeId: 0)
class MoodEntry extends HiveObject {
  /// ID unique de l'entrée
  @HiveField(0)
  String id;

  /// Date et heure de l'entrée
  @HiveField(1)
  DateTime timestamp;

  /// Niveau d'humeur de 1 (terrible) à 5 (excellent)
  @HiveField(2)
  int moodLevel;

  /// Niveau d'énergie de 1 (épuisé) à 5 (très énergique)
  @HiveField(3)
  int energyLevel;

  /// Niveau de stress de 1 (détendu) à 5 (très stressé)
  @HiveField(4)
  int stressLevel;

  /// Qualité du sommeil de 1 (très mauvaise) à 5 (excellente)
  @HiveField(5)
  int sleepQuality;

  /// Notes personnelles optionnelles
  @HiveField(6)
  String? notes;

  /// Tags associés à l'humeur (ex: "travail", "famille", "santé")
  @HiveField(7)
  List<String> tags;

  /// Activités de la journée
  @HiveField(8)
  List<String> activities;

  /// Indicateurs de symptômes de burnout
  @HiveField(9)
  Map<String, bool> burnoutSymptoms;

  MoodEntry({
    required this.id,
    required this.timestamp,
    required this.moodLevel,
    required this.energyLevel,
    required this.stressLevel,
    required this.sleepQuality,
    this.notes,
    required this.tags,
    required this.activities,
    required this.burnoutSymptoms,
  });

  /// Crée une entrée d'humeur par défaut pour aujourd'hui
  factory MoodEntry.today() {
    return MoodEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      timestamp: DateTime.now(),
      moodLevel: 3,
      energyLevel: 3,
      stressLevel: 3,
      sleepQuality: 3,
      tags: [],
      activities: [],
      burnoutSymptoms: {},
    );
  }

  /// Score global de bien-être (0-100)
  double get wellnessScore {
    // Calcul pondéré du score de bien-être
    const double moodWeight = 0.3;
    const double energyWeight = 0.25;
    const double stressWeight = 0.25; // Inversé car plus de stress = moins de bien-être
    const double sleepWeight = 0.2;

    final double score = (
      (moodLevel * moodWeight) +
      (energyLevel * energyWeight) +
      ((6 - stressLevel) * stressWeight) + // Stress inversé
      (sleepQuality * sleepWeight)
    ) / 5 * 100;

    return score.clamp(0, 100);
  }

  /// Niveau de risque de burnout (0-100)
  double get burnoutRisk {
    double risk = 0;

    // Facteurs de stress
    if (stressLevel >= 4) risk += 25;
    if (energyLevel <= 2) risk += 20;
    if (sleepQuality <= 2) risk += 15;
    if (moodLevel <= 2) risk += 20;

    // Symptômes de burnout
    final symptomsCount = burnoutSymptoms.values.where((v) => v).length;
    risk += symptomsCount * 4; // 4 points par symptôme

    return risk.clamp(0, 100);
  }

  /// Couleur associée au niveau d'humeur
  String get moodColor {
    switch (moodLevel) {
      case 5: return '#30D158'; // Vert
      case 4: return '#32D74B'; // Vert clair
      case 3: return '#FFD60A'; // Jaune
      case 2: return '#FF9F0A'; // Orange
      case 1: return '#FF453A'; // Rouge
      default: return '#FFD60A';
    }
  }

  /// Emoji associé au niveau d'humeur
  String get moodEmoji {
    switch (moodLevel) {
      case 5: return '😊';
      case 4: return '🙂';
      case 3: return '😐';
      case 2: return '😞';
      case 1: return '😢';
      default: return '😐';
    }
  }

  /// Description textuelle du niveau d'humeur
  String get moodDescription {
    switch (moodLevel) {
      case 5: return 'Excellente';
      case 4: return 'Bonne';
      case 3: return 'Neutre';
      case 2: return 'Difficile';
      case 1: return 'Très difficile';
      default: return 'Neutre';
    }
  }

  /// Copie l'entrée avec de nouvelles valeurs
  MoodEntry copyWith({
    String? id,
    DateTime? timestamp,
    int? moodLevel,
    int? energyLevel,
    int? stressLevel,
    int? sleepQuality,
    String? notes,
    List<String>? tags,
    List<String>? activities,
    Map<String, bool>? burnoutSymptoms,
  }) {
    return MoodEntry(
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      moodLevel: moodLevel ?? this.moodLevel,
      energyLevel: energyLevel ?? this.energyLevel,
      stressLevel: stressLevel ?? this.stressLevel,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      notes: notes ?? this.notes,
      tags: tags ?? this.tags,
      activities: activities ?? this.activities,
      burnoutSymptoms: burnoutSymptoms ?? this.burnoutSymptoms,
    );
  }

  @override
  String toString() {
    return 'MoodEntry(id: $id, timestamp: $timestamp, mood: $moodLevel, energy: $energyLevel, stress: $stressLevel, sleep: $sleepQuality)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MoodEntry && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}