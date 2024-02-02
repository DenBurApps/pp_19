// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_card_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseCardEntityAdapter extends TypeAdapter<CourseCardEntity> {
  @override
  final int typeId = 8;

  @override
  CourseCardEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseCardEntity(
      name: fields[0] as String,
      lessons: (fields[1] as List).cast<LessonEntity>(),
      quizzes: (fields[2] as List).cast<QuizEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, CourseCardEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.lessons)
      ..writeByte(2)
      ..write(obj.quizzes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseCardEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
