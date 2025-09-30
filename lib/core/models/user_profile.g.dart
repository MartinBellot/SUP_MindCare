// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 3;

  @override
  UserProfile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfile(
      name: fields[0] as String,
      createdAt: fields[1] as DateTime,
      goals: fields[2] as UserGoals,
      notifications: fields[3] as NotificationPreferences,
      currentStreak: fields[4] as int,
      bestStreak: fields[5] as int,
      lastActivity: fields[6] as DateTime,
      level: fields[7] as int,
      experiencePoints: fields[8] as int,
      badges: (fields[9] as List).cast<String>(),
      display: fields[10] as DisplayPreferences,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.goals)
      ..writeByte(3)
      ..write(obj.notifications)
      ..writeByte(4)
      ..write(obj.currentStreak)
      ..writeByte(5)
      ..write(obj.bestStreak)
      ..writeByte(6)
      ..write(obj.lastActivity)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.experiencePoints)
      ..writeByte(9)
      ..write(obj.badges)
      ..writeByte(10)
      ..write(obj.display);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserGoalsAdapter extends TypeAdapter<UserGoals> {
  @override
  final int typeId = 4;

  @override
  UserGoals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserGoals(
      dailyMoodCheckins: fields[0] as int,
      dailyMeditationMinutes: fields[1] as int,
      targetSleepHours: fields[2] as double,
      maxStressLevel: fields[3] as int,
      dailyWellnessTarget: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserGoals obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.dailyMoodCheckins)
      ..writeByte(1)
      ..write(obj.dailyMeditationMinutes)
      ..writeByte(2)
      ..write(obj.targetSleepHours)
      ..writeByte(3)
      ..write(obj.maxStressLevel)
      ..writeByte(4)
      ..write(obj.dailyWellnessTarget);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserGoalsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class NotificationPreferencesAdapter
    extends TypeAdapter<NotificationPreferences> {
  @override
  final int typeId = 5;

  @override
  NotificationPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NotificationPreferences(
      moodReminders: fields[0] as bool,
      moodReminderTimes: (fields[1] as List).cast<String>(),
      meditationReminders: fields[2] as bool,
      meditationReminderTime: fields[3] as String,
      breakReminders: fields[4] as bool,
      breakReminderInterval: fields[5] as int,
      wellnessInsights: fields[6] as bool,
      burnoutAlerts: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, NotificationPreferences obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.moodReminders)
      ..writeByte(1)
      ..write(obj.moodReminderTimes)
      ..writeByte(2)
      ..write(obj.meditationReminders)
      ..writeByte(3)
      ..write(obj.meditationReminderTime)
      ..writeByte(4)
      ..write(obj.breakReminders)
      ..writeByte(5)
      ..write(obj.breakReminderInterval)
      ..writeByte(6)
      ..write(obj.wellnessInsights)
      ..writeByte(7)
      ..write(obj.burnoutAlerts);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DisplayPreferencesAdapter extends TypeAdapter<DisplayPreferences> {
  @override
  final int typeId = 6;

  @override
  DisplayPreferences read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DisplayPreferences(
      showCharts: fields[0] as bool,
      showDetailedStats: fields[1] as bool,
      showDailyTips: fields[2] as bool,
      showQuotes: fields[3] as bool,
      firstDayOfWeek: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DisplayPreferences obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.showCharts)
      ..writeByte(1)
      ..write(obj.showDetailedStats)
      ..writeByte(2)
      ..write(obj.showDailyTips)
      ..writeByte(3)
      ..write(obj.showQuotes)
      ..writeByte(4)
      ..write(obj.firstDayOfWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DisplayPreferencesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
