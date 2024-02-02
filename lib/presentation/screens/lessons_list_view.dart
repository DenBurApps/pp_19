import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/course_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/entity/course_card_entity.dart';
import 'package:pp_19/data/entity/lesson_entity.dart';
import 'package:pp_19/data/entity/quiz_entity.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';

class LessonListViewArgs {
  LessonListViewArgs({required this.card, required this.courseController});

  final CourseCardEntity card;
  final CourseController courseController;
}

class LessonListView extends StatelessWidget {
  const LessonListView({super.key, required this.card, required this.courseController});

  final CourseCardEntity card;
  final CourseController courseController;

  void _selectLesson(BuildContext context, int index) {
    courseController.selectLessonAndQuiz(index);
    Navigator.of(context).pushNamed(RouteNames.lesson, arguments: courseController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
        color: Theme.of(context).colorScheme.background,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(
            child: Row(children: [
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: ImageHelper.svgImage(SvgNames.chevronLeft),
                onPressed: () => Navigator.of(context).pop(),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 34),
                child: Column(
                  children: [
                    Text('Courses', style: Theme.of(context).textTheme.labelLarge),
                    const SizedBox(height: 5),
                    Text(
                      card.name,
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
              const Spacer(),
            ]),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: card.lessons.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: LessonCard(
                      lesson: card.lessons[index],
                      quiz: card.quizzes[index],
                      onTap: () => _selectLesson(context, index),
                    ),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.lesson, required this.quiz, required this.onTap});

  final LessonEntity lesson;
  final QuizEntity quiz;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).extension<CustomColors>()!.outcomeBg,
        ),
        child: Stack(
          children: [
            Positioned(right: -50, bottom: 0, child: ImageHelper.getImage(ImageNames.courseBg)),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: (MediaQuery.of(context).size.width - 40) / 2,
                    child: Text(
                      lesson.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    quiz.progress == -1 ? 'Not stared' : '${quiz.progress}% Completed',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 11),
                  Container(
                    height: 27,
                    width: 95,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text(
                        quiz.progress == -1 ? 'Start' : 'Continue',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Theme.of(context).colorScheme.onBackground),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
