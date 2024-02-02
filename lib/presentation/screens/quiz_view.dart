import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/course_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/data/entity/quiz_entity.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/app_button.dart';
import 'package:pp_19/presentation/widgets/fillable_divider.dart';

class QuizzesView extends StatefulWidget {
  const QuizzesView({super.key, required this.controller});

  final CourseController controller;

  @override
  State<QuizzesView> createState() => _QuizzesViewState();
}

class _QuizzesViewState extends State<QuizzesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: ValueListenableBuilder(
            valueListenable: widget.controller,
            builder: (context, state, child) {
              switch (state.quizStatus) {
                case QuizControllerStatus.progress:
                  return QuizProgressView(
                    quiz: state.activeQuiz!,
                    endQuiz: (int rightAnswers) {
                      widget.controller.endQuiz(rightAnswers);
                    },
                    controller: widget.controller,
                  );
                case QuizControllerStatus.finish:
                  return QuizFinishView(
                    rightAnswers: state.rightQuizAnswers,
                    quizzesLength: 5,
                    controller: widget.controller,
                  );
              }
            },
          ),
        ),
      ),
    );
  }
}

class QuizProgressView extends StatefulWidget {
  const QuizProgressView({
    super.key,
    required this.quiz,
    required this.endQuiz,
    required this.controller,
  });

  final QuizEntity quiz;
  final void Function(int) endQuiz;
  final CourseController controller;

  @override
  State<QuizProgressView> createState() => _QuizProgressViewState();
}

class _QuizProgressViewState extends State<QuizProgressView> {
  var _currentStep = 0;

  Map<String, List<String>> get _questionsAndAnswers => widget.quiz.questionToAnswers;

  List<String> get _questions => widget.quiz.questionToAnswers.keys.toList();

  List<List<String>> get _answers => widget.quiz.questionToAnswers.values.toList();

  var _rightAnswers = 0;

  String? _selectedAnswer;

  var _quizStatus = CurrentQuizStatus.idle;

  bool get _isLastQuestion => _currentStep == _questionsAndAnswers.length - 1;

  Future<void> _next() async {
    setState(() => _quizStatus = CurrentQuizStatus.answered);
    await Future.delayed(const Duration(milliseconds: 1500));
    if (_selectedAnswer == _answers[_currentStep][widget.quiz.correctAnswerIndices[_currentStep]]) {
      _rightAnswers++;
    }
    if (_isLastQuestion) {
      widget.endQuiz.call(_rightAnswers);
    } else {
      setState(() {
        _quizStatus = CurrentQuizStatus.idle;
        _selectedAnswer = null;
        _currentStep++;
      });
    }
  }

  void _selectAnswer(String selectedAnswer) => setState(() => _selectedAnswer = selectedAnswer);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Answer ${_currentStep + 1}/${_questions.length}',
              style: Theme.of(context).textTheme.labelLarge!,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(
                      _questions[_currentStep],
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: Theme.of(context).extension<CustomColors>()!.blue),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '${((_currentStep + 1) / (5) * 100).round()}% about your Progress',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
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
            fillPercentage: ((_currentStep + 1) / (5) * 100).round(),
            width: double.infinity,
            color: Theme.of(context).extension<CustomColors>()!.lightGrey!,
            filledColor: Theme.of(context).extension<CustomColors>()!.cyan!,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) {
                            final answer = _answers[_currentStep][index];
                            return _AnswerTile(
                              isSelected: _selectedAnswer == answer,
                              answer: answer,
                              onPressed: () => _quizStatus != CurrentQuizStatus.answered
                                  ? _selectAnswer(answer)
                                  : null,
                              isAnswered: _quizStatus == CurrentQuizStatus.answered,
                              isRigth: _selectedAnswer ==
                                  _answers[_currentStep]
                                      [widget.quiz.correctAnswerIndices[_currentStep]],
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemCount: _answers[_currentStep].length,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: AppButton(
                    width: double.infinity,
                    name: _isLastQuestion ? 'Finish' : 'Next',
                    callback: _quizStatus == CurrentQuizStatus.answered
                        ? null
                        : _selectedAnswer != null
                            ? _next
                            : null,
                    backgroundColor: Theme.of(context).colorScheme.onBackground,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _AnswerTile extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isAnswered;
  final bool isRigth;
  final VoidCallback onPressed;

  const _AnswerTile({
    required this.isSelected,
    required this.answer,
    required this.onPressed,
    required this.isAnswered,
    required this.isRigth,
  });

  Color _getTextColor(BuildContext context) {
    if (isSelected) {
      if (isAnswered) {
        if (isRigth) {
          return Theme.of(context).extension<CustomColors>()!.green!;
        } else {
          return Theme.of(context).extension<CustomColors>()!.red!;
        }
      } else {
        return Theme.of(context).extension<CustomColors>()!.lighterBlack!.withOpacity(0.2);
      }
    } else {
      return Theme.of(context).extension<CustomColors>()!.lightGrey!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          height: 80,
          padding: const EdgeInsets.all(16),
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(7), color: _getTextColor(context)),
          width: double.infinity,
          child: Text(
            answer,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ));
  }
}

class QuizFinishView extends StatelessWidget {
  const QuizFinishView({
    super.key,
    required this.rightAnswers,
    required this.quizzesLength,
    required this.controller,
  });

  final int rightAnswers;
  final int quizzesLength;
  final CourseController controller;

  void _leave(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    controller.reset();
    controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    final finishImage = quizzesLength == rightAnswers
        ? ImageHelper.getImage(ImageNames.lessonFinish)
        : ImageHelper.getImage(ImageNames.lessonCover);

    final title = quizzesLength == rightAnswers ? 'King score!' : 'Unfortunately score!';

    final subTitle = quizzesLength == rightAnswers
        ? 'You have successfully completed the lesson, now you have access to the next one!'
        : "That's okay, research the info and try again.";

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Center(child: rightAnswers == 5 ? ImageHelper.getImage(ImageNames.lessonFinish) : ImageHelper.getImage(ImageNames.courseCoverBw)),
          rightAnswers == 5 ? ImageHelper.svgImage(SvgNames.stars) : ImageHelper.svgImage(SvgNames.starsEmpty),
          const SizedBox(height: 5),
          Text(rightAnswers == 5 ? 'Perfect!' : 'Bad score!', style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 12),
          Text.rich(
            TextSpan(
              text: 'You have successfully completed the quiz, now you have access to the next one!\n',
              style: Theme.of(context).textTheme.displayMedium,
              children: [
                TextSpan(
                    text: '$rightAnswers/5 correct answers',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: rightAnswers == 5 ? Theme.of(context).extension<CustomColors>()!.cyan : Theme.of(context).extension<CustomColors>()!.darkRed)),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: AppButton(
              name: 'Finish',
              callback: () => _leave(context),
              width: double.infinity,
              backgroundColor: Theme.of(context).colorScheme.onBackground,
              textColor: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}

enum CurrentQuizStatus {
  idle,
  answered,
}
