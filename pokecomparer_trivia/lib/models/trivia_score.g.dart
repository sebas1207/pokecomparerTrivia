// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_score.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TriviaScoreAdapter extends TypeAdapter<TriviaScore> {
  @override
  final int typeId = 1;

  @override
  TriviaScore read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TriviaScore(
      score: fields[0] as int,
      total: fields[1] as int,
      timestamp: fields[2] as DateTime,
      synced: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TriviaScore obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.score)
      ..writeByte(1)
      ..write(obj.total)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.synced);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriviaScoreAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
