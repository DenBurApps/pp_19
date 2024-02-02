import 'package:hive/hive.dart';
import 'package:pp_19/data/entity/lesson_entity.dart';
import 'package:pp_19/data/entity/quiz_entity.dart';

part 'course_card_entity.g.dart';

@HiveType(typeId: 8)
class CourseCardEntity {
  CourseCardEntity({
    required this.name,
    required this.lessons,
    required this.quizzes,
  });

  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final List<LessonEntity> lessons;
  @HiveField(2)
  late final List<QuizEntity> quizzes;

  CourseCardEntity copyWith({
    String? name,
    List<LessonEntity>? lessons,
    List<QuizEntity>? quizzes,
  }) =>
      CourseCardEntity(
        name: name ?? this.name,
        lessons: lessons ?? this.lessons,
        quizzes: quizzes ?? this.quizzes,
      );
}
