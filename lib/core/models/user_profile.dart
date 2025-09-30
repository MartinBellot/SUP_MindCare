import 'package:hive/hive.dart';

part 'user_profile.g.dart';

/// Profil utilisateur avec préférences et données personnelles
@HiveType(typeId: 3)
class UserProfile extends HiveObject {
  /// Nom d'utilisateur
  @HiveField(0)
  String name;

  /// Date de création du profil
  @HiveField(1)
  DateTime createdAt;

  /// Objectifs quotidiens
  @HiveField(2)
  UserGoals goals;

  /// Préférences de notifications
  @HiveField(3)
  NotificationPreferences notifications;

  /// Streak actuel (jours consécutifs d'utilisation)
  @HiveField(4)
  int currentStreak;

  /// Meilleur streak jamais atteint
  @HiveField(5)
  int bestStreak;

  /// Dernière utilisation de l'app
  @HiveField(6)
  DateTime lastActivity;

  /// Niveau de l'utilisateur (basé sur l'activité)
  @HiveField(7)
  int level;

  /// Points d'expérience
  @HiveField(8)
  int experiencePoints;

  /// Badges obtenus
  @HiveField(9)
  List<String> badges;

  /// Préférences d'affichage
  @HiveField(10)
  DisplayPreferences display;

  UserProfile({
    required this.name,
    required this.createdAt,
    required this.goals,
    required this.notifications,
    this.currentStreak = 0,
    this.bestStreak = 0,
    required this.lastActivity,
    this.level = 1,
    this.experiencePoints = 0,
    required this.badges,
    required this.display,
  });

  /// Crée un profil par défaut
  factory UserProfile.defaultProfile(String name) {
    final now = DateTime.now();
    return UserProfile(
      name: name,
      createdAt: now,
      goals: UserGoals.defaultGoals(),
      notifications: NotificationPreferences.defaultPreferences(),
      lastActivity: now,
      badges: [],
      display: DisplayPreferences.defaultPreferences(),
    );
  }

  /// Points nécessaires pour le prochain niveau
  int get pointsToNextLevel {
    return (level * 100) - experiencePoints;
  }

  /// Pourcentage de progression vers le prochain niveau
  double get levelProgress {
    final currentLevelPoints = (level - 1) * 100;
    final nextLevelPoints = level * 100;
    final progressPoints = experiencePoints - currentLevelPoints;
    return (progressPoints / (nextLevelPoints - currentLevelPoints)) * 100;
  }

  /// Ajoute des points d'expérience
  void addExperience(int points) {
    experiencePoints += points;
    
    // Vérifier si on monte de niveau
    while (experiencePoints >= level * 100) {
      level++;
    }
  }

  /// Met à jour le streak
  void updateStreak() {
    final now = DateTime.now();
    final lastDate = DateTime(lastActivity.year, lastActivity.month, lastActivity.day);
    final todayDate = DateTime(now.year, now.month, now.day);
    
    if (lastDate.isAtSameMomentAs(todayDate)) {
      // Déjà utilisé aujourd'hui
      return;
    } else if (lastDate.isAtSameMomentAs(todayDate.subtract(const Duration(days: 1)))) {
      // Utilisé hier, on continue le streak
      currentStreak++;
    } else {
      // Pas utilisé hier, on remet le streak à 1
      currentStreak = 1;
    }
    
    // Mettre à jour le meilleur streak
    if (currentStreak > bestStreak) {
      bestStreak = currentStreak;
    }
    
    lastActivity = now;
  }

  /// Copie le profil avec de nouvelles valeurs
  UserProfile copyWith({
    String? name,
    DateTime? createdAt,
    UserGoals? goals,
    NotificationPreferences? notifications,
    int? currentStreak,
    int? bestStreak,
    DateTime? lastActivity,
    int? level,
    int? experiencePoints,
    List<String>? badges,
    DisplayPreferences? display,
  }) {
    return UserProfile(
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      goals: goals ?? this.goals,
      notifications: notifications ?? this.notifications,
      currentStreak: currentStreak ?? this.currentStreak,
      bestStreak: bestStreak ?? this.bestStreak,
      lastActivity: lastActivity ?? this.lastActivity,
      level: level ?? this.level,
      experiencePoints: experiencePoints ?? this.experiencePoints,
      badges: badges ?? this.badges,
      display: display ?? this.display,
    );
  }
}

/// Objectifs quotidiens de l'utilisateur
@HiveType(typeId: 4)
class UserGoals extends HiveObject {
  /// Nombre de check-ins d'humeur quotidiens souhaités
  @HiveField(0)
  int dailyMoodCheckins;

  /// Minutes de méditation quotidiennes souhaitées
  @HiveField(1)
  int dailyMeditationMinutes;

  /// Nombre d'heures de sommeil souhaitées
  @HiveField(2)
  double targetSleepHours;

  /// Niveau de stress maximum acceptable (1-5)
  @HiveField(3)
  int maxStressLevel;

  /// Objectif de bien-être quotidien (0-100)
  @HiveField(4)
  double dailyWellnessTarget;

  UserGoals({
    required this.dailyMoodCheckins,
    required this.dailyMeditationMinutes,
    required this.targetSleepHours,
    required this.maxStressLevel,
    required this.dailyWellnessTarget,
  });

  /// Objectifs par défaut
  factory UserGoals.defaultGoals() {
    return UserGoals(
      dailyMoodCheckins: 2,
      dailyMeditationMinutes: 10,
      targetSleepHours: 8.0,
      maxStressLevel: 3,
      dailyWellnessTarget: 70.0,
    );
  }
}

/// Préférences de notifications
@HiveType(typeId: 5)
class NotificationPreferences extends HiveObject {
  /// Rappels d'humeur activés
  @HiveField(0)
  bool moodReminders;

  /// Heures des rappels d'humeur
  @HiveField(1)
  List<String> moodReminderTimes;

  /// Rappels de méditation activés
  @HiveField(2)
  bool meditationReminders;

  /// Heure du rappel de méditation
  @HiveField(3)
  String meditationReminderTime;

  /// Rappels de pause activés
  @HiveField(4)
  bool breakReminders;

  /// Intervalle des rappels de pause (en minutes)
  @HiveField(5)
  int breakReminderInterval;

  /// Notifications de bien-être activées
  @HiveField(6)
  bool wellnessInsights;

  /// Alertes de burnout activées
  @HiveField(7)
  bool burnoutAlerts;

  NotificationPreferences({
    required this.moodReminders,
    required this.moodReminderTimes,
    required this.meditationReminders,
    required this.meditationReminderTime,
    required this.breakReminders,
    required this.breakReminderInterval,
    required this.wellnessInsights,
    required this.burnoutAlerts,
  });

  /// Préférences par défaut
  factory NotificationPreferences.defaultPreferences() {
    return NotificationPreferences(
      moodReminders: true,
      moodReminderTimes: ['09:00', '18:00'],
      meditationReminders: true,
      meditationReminderTime: '20:00',
      breakReminders: false,
      breakReminderInterval: 120,
      wellnessInsights: true,
      burnoutAlerts: true,
    );
  }
}

/// Préférences d'affichage
@HiveType(typeId: 6)
class DisplayPreferences extends HiveObject {
  /// Affichage des graphiques activé
  @HiveField(0)
  bool showCharts;

  /// Affichage des statistiques détaillées
  @HiveField(1)
  bool showDetailedStats;

  /// Affichage des conseils quotidiens
  @HiveField(2)
  bool showDailyTips;

  /// Affichage des citations inspirantes
  @HiveField(3)
  bool showQuotes;

  /// Premier jour de la semaine (0 = dimanche, 1 = lundi)
  @HiveField(4)
  int firstDayOfWeek;

  DisplayPreferences({
    required this.showCharts,
    required this.showDetailedStats,
    required this.showDailyTips,
    required this.showQuotes,
    required this.firstDayOfWeek,
  });

  /// Préférences par défaut
  factory DisplayPreferences.defaultPreferences() {
    return DisplayPreferences(
      showCharts: true,
      showDetailedStats: true,
      showDailyTips: true,
      showQuotes: true,
      firstDayOfWeek: 1, // Lundi
    );
  }
}