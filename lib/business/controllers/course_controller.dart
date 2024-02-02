import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_19/data/database/database_service.dart';
import 'package:pp_19/data/entity/course_card_entity.dart';
import 'package:pp_19/data/entity/lesson_entity.dart';
import 'package:pp_19/data/entity/quiz_entity.dart';

class CourseController extends ValueNotifier<CourseControllerState> {
  CourseController() : super(CourseControllerState.initial()) {
    initialize();
  }

  LessonEntity? get activeLesson => value.activeLesson;
  QuizEntity? get activeQuiz => value.activeQuiz;
  CourseCardEntity? get activeCard => value.activeCard;
  List<CourseCardEntity> get allCards => dataBase.getCards();

  final dataBase = GetIt.I.get<DatabaseService>();

  void initialize() {
    final courses = dataBase.getCards();
    final generalProgress = _calculateGeneralProgress();
    value = value.copyWith(courses: courses, generalProgress: generalProgress);
    notifyListeners();
  }

  void selectCard(CourseCardEntity card) {
    value = value.copyWith(activeCard: card);
    notifyListeners();
  }

  void selectLessonAndQuiz(int index) {
    final lesson = value.activeCard!.lessons[index];
    final quiz = value.activeCard!.quizzes[index];
    value = value.copyWith(activeLesson: lesson, activeQuiz: quiz);
    notifyListeners();
  }

  void makeReadLesson(LessonEntity lesson) {
    dataBase.makeReadLesson(lesson);
    initialize();
  }

  void finishLesson() {
    value = value.copyWith(lessonStatus: LessonControllerStatus.finish);
    notifyListeners();
  }

  void startLesson() {
    value = value.copyWith(lessonStatus: LessonControllerStatus.progress);
    notifyListeners();
  }

  void startQuiz() {
    value = value.copyWith(quizStatus: QuizControllerStatus.progress);
    notifyListeners();
  }


  void endQuiz(int rightAnswers) {
    value = value.copyWith(
      quizStatus: QuizControllerStatus.finish,
      rightQuizAnswers: rightAnswers,
    );
    notifyListeners();

    final quizProgress = rightAnswers != 0 ? ((rightAnswers / 5) * 100).round() : 0;
    dataBase.finishTheQuiz(value.activeQuiz!, quizProgress);
  }

  void reset() {
    value = value.copyWith(
      courses: [],
      activeCard: null,
      activeLesson: null,
      activeQuiz: null,
      lessonStatus: LessonControllerStatus.idle,
      quizStatus: QuizControllerStatus.progress,
    );
    notifyListeners();
  }

  int _calculateGeneralProgress() {
    int result = 0;
    for (var item in allCards) {
      for (var quiz in item.quizzes) {
        if (quiz.progress == 100) {
          result++;
        }
      }
    }
    return ((result/15)*100).round();
  }
}

class CourseControllerState {
  final List<CourseCardEntity> courses;
  final CourseCardEntity? activeCard;
  final LessonEntity? activeLesson;
  final QuizEntity? activeQuiz;
  final LessonControllerStatus lessonStatus;
  final QuizControllerStatus quizStatus;
  final int rightQuizAnswers;
  final int generalProgress;


  CourseControllerState({
    required this.courses,
    required this.activeCard,
    required this.activeLesson,
    required this.activeQuiz,
    required this.rightQuizAnswers,
    required this.lessonStatus,
    required this.quizStatus,
    required this.generalProgress,
  });

  factory CourseControllerState.initial() {
    return CourseControllerState(
      courses: [],
      activeCard: null,
      activeLesson: null,
      activeQuiz: null,
      rightQuizAnswers: 0,
      lessonStatus: LessonControllerStatus.idle,
      quizStatus: QuizControllerStatus.progress,
      generalProgress: 0,
    );
  }

  CourseControllerState copyWith({
    List<CourseCardEntity>? courses,
    CourseCardEntity? activeCard,
    LessonEntity? activeLesson,
    QuizEntity? activeQuiz,
    int? rightQuizAnswers,
    LessonControllerStatus? lessonStatus,
    QuizControllerStatus? quizStatus,
    int? generalProgress,
  }) {
    return CourseControllerState(
      courses: courses ?? this.courses,
      activeCard: activeCard ?? this.activeCard,
      activeLesson: activeLesson ?? this.activeLesson,
      activeQuiz: activeQuiz ?? this.activeQuiz,
      rightQuizAnswers: rightQuizAnswers ?? this.rightQuizAnswers,
      lessonStatus: lessonStatus ?? this.lessonStatus,
      quizStatus: quizStatus ?? this.quizStatus,
      generalProgress: generalProgress ?? this.generalProgress,
    );
  }
}

enum LessonControllerStatus {
  idle,
  progress,
  finish,
}

enum QuizControllerStatus {
  progress,
  finish,
}