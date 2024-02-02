import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/course_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/app_button.dart';
import 'package:pp_19/presentation/widgets/fillable_divider.dart';

class LessonView extends StatefulWidget {
  const LessonView({super.key, required this.courseController});

  final CourseController courseController;

  @override
  State<LessonView> createState() => _LessonViewState();
}

class _LessonViewState extends State<LessonView> {
  var steps = <String>[];
  var currentStep = 0;

  @override
  void initState() {
    steps = widget.courseController.activeLesson!.splitTextIntoSteps(146);
    super.initState();
  }

  void _increaseStep() {
    if (currentStep + 1 < steps.length) {
      setState(() {
        currentStep += 1;
      });
    } else if (currentStep + 1 == steps.length) {
      if (!widget.courseController.activeLesson!.isRead) {
        widget.courseController.makeReadLesson(widget.courseController.activeLesson!);
      }
      widget.courseController.finishLesson();
    }
  }

  void _decreaseStep() {
    if (currentStep - 1 > -1) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      widget.courseController.reset();
      widget.courseController.initialize();
    }
  }

  @override
  Widget build(BuildContext context) {
    var previewText = widget.courseController.activeLesson!.text.split('.')[0];

    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: widget.courseController,
        builder: (BuildContext context, CourseControllerState state, Widget? child) {
          switch (state.lessonStatus) {
            case LessonControllerStatus.idle:
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              widget.courseController.activeLesson!.name,
                              style: Theme.of(context).textTheme.labelMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ]),
                    ),
                    const SizedBox(height: 20),
                    ImageHelper.getImage(ImageNames.lessonCover),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                'Fundamentals of Financial Literacy',
                                maxLines: 3,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${widget.courseController.activeQuiz!.progress != -1
                                  ? widget.courseController.activeQuiz!.progress
                                  : 0}% about your Progress',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                            )
                          ],
                        ),
                        const Spacer(),
                        Center(
                          child: ImageHelper.svgImage(SvgNames.study),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    FillableDivider(
                      fillPercentage: widget.courseController.activeQuiz!.progress != -1
                          ? widget.courseController.activeQuiz!.progress
                          : 0,
                      width: double.infinity,
                      color: Theme.of(context).extension<CustomColors>()!.lightGrey!,
                      filledColor: Theme.of(context).extension<CustomColors>()!.cyan!,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 85,
                      child: Text(
                        previewText,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TakeTestButton(
                      callback: () {
                        widget.courseController.finishLesson();
                        Navigator.of(context).pushReplacementNamed(
                          RouteNames.quiz,
                          arguments: widget.courseController,
                        );
                      },
                      isActive: widget.courseController.activeLesson!.isRead,
                    ),
                    const SizedBox(height: 17),
                    AppButton(
                      name: 'Get started',
                      callback: widget.courseController.startLesson,
                      width: double.infinity,
                      backgroundColor: Theme.of(context).colorScheme.onBackground,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    )
                  ],
                ),
              );
            case LessonControllerStatus.progress:
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(children: [
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          onPressed: _decreaseStep,
                          child: ImageHelper.svgImage(SvgNames.chevronLeft),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 34),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              'Step ${currentStep + 1}/${steps.length}',
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ]),
                    ),
                    const SizedBox(height: 26),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: Text(
                                'Fundamentals of Financial Literacy',
                                maxLines: 3,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              '${((currentStep + 1) / (steps.length) * 100).round()}% about your Progress',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                            )
                          ],
                        ),
                        const Spacer(),
                        Center(
                          child: ImageHelper.svgImage(SvgNames.study),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    FillableDivider(
                      fillPercentage: ((currentStep + 1) / (steps.length) * 100).round(),
                      width: double.infinity,
                      color: Theme.of(context).extension<CustomColors>()!.lightGrey!,
                      filledColor: Theme.of(context).extension<CustomColors>()!.cyan!,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      steps[currentStep],
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: AppButton(
                        name: currentStep + 1 == steps.length ? 'Finish' : 'Next',
                        callback: _increaseStep,
                        width: double.infinity,
                        backgroundColor: Theme.of(context).colorScheme.onBackground,
                        textColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  ],
                ),
              );
            case LessonControllerStatus.finish:
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    Center(child: ImageHelper.getImage(ImageNames.lessonFinish)),
                    ImageHelper.svgImage(SvgNames.stars),
                    const SizedBox(height: 5),
                    Text('Perfect', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        text: 'You have successfully passed the theoretical part!',
                        style: Theme.of(context).textTheme.displayMedium,
                        children: [
                          TextSpan(
                              text: 'Would you like to be tested on the material you have learned?',
                              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                                  color: Theme.of(context).extension<CustomColors>()!.cyan)),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Column(
                        children: [
                          AppButton(
                            name: 'Start',
                            callback: () => Navigator.of(context).pushReplacementNamed(
                              RouteNames.quiz,
                              arguments: widget.courseController,
                            ),
                            width: double.infinity,
                            backgroundColor: Theme.of(context).colorScheme.onBackground,
                            textColor: Theme.of(context).colorScheme.onPrimary,
                          ),
                          AppButton(
                            name: 'Later',
                            callback: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              widget.courseController.reset();
                              widget.courseController.initialize();
                            },
                            width: double.infinity,
                            backgroundColor: Colors.transparent,
                            textStyle: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(color: Theme.of(context).colorScheme.onBackground),
                            textColor: Theme.of(context).colorScheme.onBackground,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}

class TakeTestButton extends StatelessWidget {
  const TakeTestButton({super.key, required this.callback, required this.isActive});

  final VoidCallback callback;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: isActive ? callback : null,
      padding: EdgeInsets.zero,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).extension<CustomColors>()!.incomeBg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Take the test',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: isActive
                      ? Theme.of(context).extension<CustomColors>()!.lighterBlack
                      : Theme.of(context)
                          .extension<CustomColors>()!
                          .lighterBlack!
                          .withOpacity(0.5)),
            ),
            isActive
                ? ImageHelper.svgImage(SvgNames.longChevronRight)
                : ImageHelper.svgImage(SvgNames.lock),
          ],
        ),
      ),
    );
  }
}
