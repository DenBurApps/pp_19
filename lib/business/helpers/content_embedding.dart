import 'package:pp_19/business/helpers/lessons_text.dart';
import 'package:pp_19/business/helpers/quizzes_text.dart';
import 'package:pp_19/data/entity/course_card_entity.dart';
import 'package:pp_19/data/entity/lesson_entity.dart';
import 'package:pp_19/data/entity/quiz_entity.dart';

class ContentEmbedding {
  static List<CourseCardEntity> getCards = [
    CourseCardEntity(
      name: 'Financial planning',
      lessons: [
        LessonEntity(name: 'Budgeting and cost planning', text: LessonsText.first, isRead: false),
        LessonEntity(name: 'Debt and credit management', text: LessonsText.second, isRead: false),
        LessonEntity(
            name: 'Investments and financial instruments', text: LessonsText.third, isRead: false),
        LessonEntity(
            name: 'Tax planning and optimization', text: LessonsText.fourth, isRead: false),
        LessonEntity(
            name: 'Financial literacy for entrepreneurs', text: LessonsText.fifth, isRead: false),
      ],
      quizzes: [
        QuizEntity(
            questionToAnswers: QuizzesText.first,
            correctAnswerIndices: [2, 2, 3, 3, 2],
            progress: -1),
        QuizEntity(
            questionToAnswers: QuizzesText.second,
            correctAnswerIndices: [2, 2, 2, 1, 1],
            progress: -1),
        QuizEntity(
            questionToAnswers: QuizzesText.third,
            correctAnswerIndices: [2, 2, 2, 2, 1],
            progress: -1),
        QuizEntity(
            questionToAnswers: QuizzesText.fourth,
            correctAnswerIndices: [1, 0, 2, 1, 0],
            progress: -1),
        QuizEntity(
            questionToAnswers: QuizzesText.fifth,
            correctAnswerIndices: [1, 0, 2, 0, 1],
            progress: -1),
      ],
    ),
    CourseCardEntity(name: 'Personal financial management', lessons: [
      LessonEntity(name: 'Basics of personal finance and income management', text: LessonsText.sixth, isRead: false),
      LessonEntity(name: 'Insurance and protection against financial risks', text: LessonsText.seventh, isRead: false),
      LessonEntity(
          name: 'Pension planning and saving for the future', text: LessonsText.eighth, isRead: false),
      LessonEntity(name: 'Financial strategies to achieve financial independence', text: LessonsText.ninth, isRead: false),
      LessonEntity(
          name: 'Financial decisions when buying real estate or a car', text: LessonsText.tenth, isRead: false),
    ], quizzes: [
      QuizEntity(
          questionToAnswers: QuizzesText.sixth,
          correctAnswerIndices: [1, 1, 0, 2, 1],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.seventh,
          correctAnswerIndices: [0, 0, 0, 0, 0],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.eighth,
          correctAnswerIndices: [0, 0, 2, 0, 2],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.ninth,
          correctAnswerIndices: [2, 2, 0, 1, 0],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.ten,
          correctAnswerIndices: [1, 3, 0, 2, 1],
          progress: -1),
    ]),
    CourseCardEntity(name: 'Financial analysis and investments', lessons: [
      LessonEntity(name: 'Financial markets and instruments', text: LessonsText.eleven, isRead: false),
      LessonEntity(name: 'Financial analysis and business planning', text: LessonsText.twelve, isRead: false),
      LessonEntity(
          name: 'Personal investment management', text: LessonsText.trendy, isRead: false),
      LessonEntity(name: 'Financial decisions in family life', text: LessonsText.fourteenth, isRead: false),
      LessonEntity(
          name: 'Financial literacy for youth and students', text: LessonsText.fifteenth, isRead: false),
    ], quizzes: [
      QuizEntity(
          questionToAnswers: QuizzesText.eleven,
          correctAnswerIndices: [2, 0, 0, 1, 2],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.twelve,
          correctAnswerIndices: [0, 0, 0, 0, 0],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.thirteenth,
          correctAnswerIndices: [0, 2, 0, 2, 0],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.fourteenth,
          correctAnswerIndices: [1, 0, 0, 1, 1],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.fifteenth,
          correctAnswerIndices: [3, 0, 2, 0, 1],
          progress: -1),
    ]),
    CourseCardEntity(name: 'Modern aspects of finance', lessons: [
      LessonEntity(name: 'Financial technologies and digital platforms', text: LessonsText.sixteenth, isRead: false),
      LessonEntity(name: 'Managing personal finances in an economic crisis', text: LessonsText.seventeenth, isRead: false),
      LessonEntity(
          name: 'Financial literacy for women', text: LessonsText.eighteenth, isRead: false),
      LessonEntity(name: 'Financial literacy for older people', text: LessonsText.nineteenth, isRead: false),
      LessonEntity(
          name: 'Ethics and responsibility in financial decisions', text: LessonsText.twenty, isRead: false),
    ], quizzes: [
      QuizEntity(
          questionToAnswers: QuizzesText.sixteenth,
          correctAnswerIndices: [3, 1, 1, 1, 0],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.seventeenth,
          correctAnswerIndices: [2, 1, 2, 1, 1],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.eighteenth,
          correctAnswerIndices: [0, 0, 0, 0, 2],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.nineteenth,
          correctAnswerIndices: [0, 0, 0, 0, 2],
          progress: -1),
      QuizEntity(
          questionToAnswers: QuizzesText.twentieth,
          correctAnswerIndices: [1, 2, 0, 3, 2],
          progress: -1),
    ])
  ];

}
