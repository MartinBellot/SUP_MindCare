// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditation_session.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeditationSessionAdapter extends TypeAdapter<MeditationSession> {
  @override
  final int typeId = 1;

  @override
  MeditationSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MeditationSession(
      id: fields[0] as String,
      startTime: fields[1] as DateTime,
      endTime: fields[2] as DateTime?,
      type: fields[3] as MeditationType,
      plannedDurationMinutes: fields[4] as int,
      actualDurationMinutes: fields[5] as int?,
      completed: fields[6] as bool,
      relaxationLevel: fields[7] as int?,
      concentrationLevel: fields[8] as int?,
      notes: fields[9] as String?,
      interruptions: fields[10] as int,
      techniques: (fields[11] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MeditationSession obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.plannedDurationMinutes)
      ..writeByte(5)
      ..write(obj.actualDurationMinutes)
      ..writeByte(6)
      ..write(obj.completed)
      ..writeByte(7)
      ..write(obj.relaxationLevel)
      ..writeByte(8)
      ..write(obj.concentrationLevel)
      ..writeByte(9)
      ..write(obj.notes)
      ..writeByte(10)
      ..write(obj.interruptions)
      ..writeByte(11)
      ..write(obj.techniques);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeditationSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MeditationTypeAdapter extends TypeAdapter<MeditationType> {
  @override
  final int typeId = 2;

  @override
  MeditationType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MeditationType.breathing;
      case 1:
        return MeditationType.mindfulness;
      case 2:
        return MeditationType.bodyScan;
      case 3:
        return MeditationType.visualization;
      case 4:
        return MeditationType.sleep;
      case 5:
        return MeditationType.stress;
      case 6:
        return MeditationType.focus;
      case 7:
        return MeditationType.gratitude;
      default:
        return MeditationType.breathing;
    }
  }

  @override
  void write(BinaryWriter writer, MeditationType obj) {
    switch (obj) {
      case MeditationType.breathing:
        writer.writeByte(0);
        break;
      case MeditationType.mindfulness:
        writer.writeByte(1);
        break;
      case MeditationType.bodyScan:
        writer.writeByte(2);
        break;
      case MeditationType.visualization:
        writer.writeByte(3);
        break;
      case MeditationType.sleep:
        writer.writeByte(4);
        break;
      case MeditationType.stress:
        writer.writeByte(5);
        break;
      case MeditationType.focus:
        writer.writeByte(6);
        break;
      case MeditationType.gratitude:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeditationTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
