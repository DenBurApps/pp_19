// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizEntityAdapter extends TypeAdapter<QuizEntity> {
  @override
  final int typeId = 7;

  @override
  QuizEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizEntity(
      questionToAnswers: (fields[0] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as String, (v as List).cast<String>())),
      correctAnswerIndices: (fields[1] as List).cast<int>(),
      progress: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuizEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.questionToAnswers)
      ..writeByte(1)
      ..write(obj.correctAnswerIndices)
      ..writeByte(2)
      ..write(obj.progress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
