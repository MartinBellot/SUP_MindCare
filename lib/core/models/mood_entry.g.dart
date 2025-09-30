// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoodEntryAdapter extends TypeAdapter<MoodEntry> {
  @override
  final int typeId = 0;

  @override
  MoodEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoodEntry(
      id: fields[0] as String,
      timestamp: fields[1] as DateTime,
      moodLevel: fields[2] as int,
      energyLevel: fields[3] as int,
      stressLevel: fields[4] as int,
      sleepQuality: fields[5] as int,
      notes: fields[6] as String?,
      tags: (fields[7] as List).cast<String>(),
      activities: (fields[8] as List).cast<String>(),
      burnoutSymptoms: (fields[9] as Map).cast<String, bool>(),
    );
  }

  @override
  void write(BinaryWriter writer, MoodEntry obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.moodLevel)
      ..writeByte(3)
      ..write(obj.energyLevel)
      ..writeByte(4)
      ..write(obj.stressLevel)
      ..writeByte(5)
      ..write(obj.sleepQuality)
      ..writeByte(6)
      ..write(obj.notes)
      ..writeByte(7)
      ..write(obj.tags)
      ..writeByte(8)
      ..write(obj.activities)
      ..writeByte(9)
      ..write(obj.burnoutSymptoms);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
