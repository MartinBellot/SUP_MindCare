import 'package:hive/hive.dart';

part 'meditation_session.g.dart';

/// Types de méditation disponibles
@HiveType(typeId: 2)
enum MeditationType {
  @HiveField(0)
  breathing('Respiration', 'Exercices de respiration guidée'),
  @HiveField(1)
  mindfulness('Pleine conscience', 'Méditation de pleine conscience'),
  @HiveField(2)
  bodyScan('Scan corporel', 'Relaxation progressive du corps'),
  @HiveField(3)
  visualization('Visualisation', 'Méditation par visualisation'),
  @HiveField(4)
  sleep('Sommeil', 'Méditation pour favoriser le sommeil'),
  @HiveField(5)
  stress('Anti-stress', 'Méditation pour réduire le stress'),
  @HiveField(6)
  focus('Concentration', 'Méditation pour améliorer la concentration'),
  @HiveField(7)
  gratitude('Gratitude', 'Méditation de gratitude');

  const MeditationType(this.displayName, this.description);
  
  final String displayName;
  final String description;
}

/// Représente une session de méditation
@HiveType(typeId: 1)
class MeditationSession extends HiveObject {
  /// ID unique de la session
  @HiveField(0)
  String id;

  /// Date et heure de début de la session
  @HiveField(1)
  DateTime startTime;

  /// Date et heure de fin de la session
  @HiveField(2)
  DateTime? endTime;

  /// Type de méditation
  @HiveField(3)
  MeditationType type;

  /// Durée planifiée en minutes
  @HiveField(4)
  int plannedDurationMinutes;

  /// Durée réelle de la session en minutes
  @HiveField(5)
  int? actualDurationMinutes;

  /// Session complétée ou interrompue
  @HiveField(6)
  bool completed;

  /// Niveau de relaxation ressenti après (1-5)
  @HiveField(7)
  int? relaxationLevel;

  /// Facilité de concentration pendant la session (1-5)
  @HiveField(8)
  int? concentrationLevel;

  /// Notes personnelles
  @HiveField(9)
  String? notes;

  /// Nombre d'interruptions pendant la session
  @HiveField(10)
  int interruptions;

  /// Techniques utilisées pendant la session
  @HiveField(11)
  List<String> techniques;

  MeditationSession({
    required this.id,
    required this.startTime,
    this.endTime,
    required this.type,
    required this.plannedDurationMinutes,
    this.actualDurationMinutes,
    this.completed = false,
    this.relaxationLevel,
    this.concentrationLevel,
    this.notes,
    this.interruptions = 0,
    required this.techniques,
  });

  /// Crée une nouvelle session de méditation
  factory MeditationSession.create({
    required MeditationType type,
    required int durationMinutes,
    List<String>? techniques,
  }) {
    return MeditationSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      startTime: DateTime.now(),
      type: type,
      plannedDurationMinutes: durationMinutes,
      techniques: techniques ?? [],
    );
  }

  /// Durée réelle ou planifiée en minutes
  int get durationMinutes => actualDurationMinutes ?? plannedDurationMinutes;

  /// Durée en format MM:SS
  String get durationFormatted {
    final duration = Duration(minutes: durationMinutes);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  /// Pourcentage de completion (si interrompue)
  double get completionPercentage {
    if (actualDurationMinutes == null) return 0.0;
    return (actualDurationMinutes! / plannedDurationMinutes * 100).clamp(0, 100);
  }

  /// Score d'efficacité de la session (0-100)
  double get efficacyScore {
    if (!completed) return 0.0;
    
    double score = 0;
    
    // Completion
    score += completionPercentage * 0.4;
    
    // Niveau de relaxation
    if (relaxationLevel != null) {
      score += (relaxationLevel! / 5.0) * 30;
    }
    
    // Niveau de concentration
    if (concentrationLevel != null) {
      score += (concentrationLevel! / 5.0) * 20;
    }
    
    // Pénalité pour les interruptions
    score -= interruptions * 5;
    
    // Bonus pour les sessions longues
    if (durationMinutes >= 20) score += 10;
    
    return score.clamp(0, 100);
  }

  /// Couleur associée au type de méditation
  String get typeColor {
    switch (type) {
      case MeditationType.breathing:
        return '#64D2FF'; // Bleu clair
      case MeditationType.mindfulness:
        return '#30D158'; // Vert
      case MeditationType.bodyScan:
        return '#BF5AF2'; // Violet
      case MeditationType.visualization:
        return '#FF9F0A'; // Orange
      case MeditationType.sleep:
        return '#5856D6'; // Indigo
      case MeditationType.stress:
        return '#FF453A'; // Rouge (stress)
      case MeditationType.focus:
        return '#007AFF'; // Bleu
      case MeditationType.gratitude:
        return '#FF2D92'; // Rose
    }
  }

  /// Icône associée au type de méditation
  String get typeIcon {
    switch (type) {
      case MeditationType.breathing:
        return '🫁';
      case MeditationType.mindfulness:
        return '🧘';
      case MeditationType.bodyScan:
        return '✨';
      case MeditationType.visualization:
        return '🌅';
      case MeditationType.sleep:
        return '🌙';
      case MeditationType.stress:
        return '🌊';
      case MeditationType.focus:
        return '🎯';
      case MeditationType.gratitude:
        return '🙏';
    }
  }

  /// Termine la session
  void complete({
    int? relaxationLevel,
    int? concentrationLevel,
    String? notes,
  }) {
    endTime = DateTime.now();
    actualDurationMinutes = endTime!.difference(startTime).inMinutes;
    completed = true;
    this.relaxationLevel = relaxationLevel;
    this.concentrationLevel = concentrationLevel;
    this.notes = notes;
  }

  /// Copie la session avec de nouvelles valeurs
  MeditationSession copyWith({
    String? id,
    DateTime? startTime,
    DateTime? endTime,
    MeditationType? type,
    int? plannedDurationMinutes,
    int? actualDurationMinutes,
    bool? completed,
    int? relaxationLevel,
    int? concentrationLevel,
    String? notes,
    int? interruptions,
    List<String>? techniques,
  }) {
    return MeditationSession(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      type: type ?? this.type,
      plannedDurationMinutes: plannedDurationMinutes ?? this.plannedDurationMinutes,
      actualDurationMinutes: actualDurationMinutes ?? this.actualDurationMinutes,
      completed: completed ?? this.completed,
      relaxationLevel: relaxationLevel ?? this.relaxationLevel,
      concentrationLevel: concentrationLevel ?? this.concentrationLevel,
      notes: notes ?? this.notes,
      interruptions: interruptions ?? this.interruptions,
      techniques: techniques ?? this.techniques,
    );
  }

  @override
  String toString() {
    return 'MeditationSession(id: $id, type: $type, duration: ${durationMinutes}min, completed: $completed)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MeditationSession && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}