import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/course_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/entity/course_card_entity.dart';
import 'package:pp_19/presentation/screens/lessons_list_view.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/fillable_divider.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  final _courseController = CourseController();

  @override
  void dispose() {
    _courseController.dispose();
    super.dispose();
  }

  void _openCard(CourseCardEntity card) {
    _courseController.selectCard(card);
    Navigator.of(context).pushNamed(RouteNames.lessonsList,
        arguments: LessonListViewArgs(card: card, courseController: _courseController));
  }

  int _calculatePassedQuizzes(CourseCardEntity card) {
    var result = 0;
    for (var item in card.quizzes) {
      if (item.progress == 100) {
        result++;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
          valueListenable: _courseController,
          builder: (BuildContext context, CourseControllerState state, Widget? child) {
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              color: Theme.of(context).colorScheme.background,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text('Courses', style: Theme.of(context).textTheme.labelLarge),
                        const SizedBox(height: 5),
                        Text(
                          'Financial Literacy',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 27),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Financial Literacy Study',
                                  style: Theme.of(context).textTheme.labelMedium),
                              const SizedBox(height: 5),
                              Text(
                                '${state.generalProgress}% about your progress',
                                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground
                                        .withOpacity(0.5)),
                              )
                            ],
                          ),
                          const Spacer(),
                          ImageHelper.svgImage(SvgNames.study),
                        ],
                      ),
                      const SizedBox(height: 15),
                      FillableDivider(
                        fillPercentage: state.generalProgress,
                        width: double.infinity,
                        color: Theme.of(context).extension<CustomColors>()!.lightGrey!,
                        filledColor: Theme.of(context).extension<CustomColors>()!.cyan!,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: state.courses.length,
                        itemBuilder: (context, index) {
                          final passedQuizzes = _calculatePassedQuizzes(state.courses[index]);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: CourseCard(
                              card: state.courses[index],
                              index: index,
                              onCardOpen: _openCard,
                              passedQuizzes: passedQuizzes,
                            ),
                          );
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.card,
    required this.index,
    required this.onCardOpen,
    required this.passedQuizzes,
  });

  final CourseCardEntity card;
  final int index;
  final Function(CourseCardEntity card) onCardOpen;
  final int passedQuizzes;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => onCardOpen.call(card),
      child: Container(
        height: 160,
        decoration: BoxDecoration(
          color: index % 2 == 0
              ? Theme.of(context).extension<CustomColors>()!.incomeBg
              : Theme.of(context).extension<CustomColors>()!.outcomeBg,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight, child: ImageHelper.getImage(ImageNames.courseBg)),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 70,
                      height: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.2),
                      ),
                      child: Center(
                        child: Text('${passedQuizzes < 10 ? '0$passedQuizzes' : passedQuizzes}/30',
                            style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ),
                  ),
                  Text('${card.name.split(' ').first}\n${card.name.split(' ')[1]}',
                      style: Theme.of(context).textTheme.labelMedium),
                  const SizedBox(height: 20),
                  Container(
                    width: 94,
                    height: 27,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child:
                        Center(child: Text('Start', style: Theme.of(context).textTheme.labelSmall)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
