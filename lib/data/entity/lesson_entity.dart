import 'package:hive/hive.dart';

part 'lesson_entity.g.dart';

@HiveType(typeId: 6)
class LessonEntity {
  LessonEntity({
    required this.name,
    required this.text,
    required this.isRead,
  });

  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final String text;
  @HiveField(2)
  late final bool isRead;

  List<String> splitTextIntoSteps(int wordsPerStep) {
    List<String> steps = [];

    List<String> sentences = text.split('. ');

    int currentIndex = 0;

    while (currentIndex < sentences.length) {
      String currentStepText = '';
      int wordsInCurrentStep = 0;

      while (currentIndex < sentences.length &&
          wordsInCurrentStep + sentences[currentIndex].split(' ').length <= wordsPerStep) {
        currentStepText += '${sentences[currentIndex]}. ';
        currentIndex++;
        wordsInCurrentStep += sentences[currentIndex - 1].split(' ').length;
      }

      if (currentStepText.isNotEmpty) {
        steps.add(currentStepText.trim());
      }
    }

    return steps;
  }

  LessonEntity copyWith({String? name, String? text, bool? isRead}) => LessonEntity(
        name: name ?? this.name,
        text: text ?? this.text,
        isRead: isRead ?? this.isRead,
      );
}
