import 'package:hive/hive.dart';

part 'quiz_entity.g.dart';

@HiveType(typeId: 7)
class QuizEntity {
  QuizEntity({
    required this.questionToAnswers,
    required this.correctAnswerIndices,
    required this.progress,
  });

  @HiveField(0)
  late final Map<String, List<String>> questionToAnswers;
  @HiveField(1)
  late final List<int> correctAnswerIndices;
  @HiveField(2)
  late final int progress;

  QuizEntity copyWith({
    Map<String, List<String>>? questionToAnswers,
    List<int>? correctAnswerIndices,
    int? progress,
  }) =>
      QuizEntity(
        questionToAnswers: questionToAnswers ?? this.questionToAnswers,
        correctAnswerIndices: correctAnswerIndices ?? this.correctAnswerIndices,
        progress: progress ?? this.progress,
      );
}
