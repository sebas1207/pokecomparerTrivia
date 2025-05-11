// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TriviaQuestionAdapter extends TypeAdapter<TriviaQuestion> {
  @override
  final int typeId = 0;

  @override
  TriviaQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TriviaQuestion(
      question: fields[0] as String,
      options: (fields[1] as List).cast<String>(),
      correctIndex: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TriviaQuestion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.correctIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriviaQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
