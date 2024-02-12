import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp_19/business/helpers/content_embedding.dart';
import 'package:pp_19/data/entity/category_item.dart';
import 'package:pp_19/data/entity/course_card_entity.dart';
import 'package:pp_19/data/entity/lesson_entity.dart';
import 'package:pp_19/data/entity/quiz_entity.dart';
import 'package:pp_19/data/entity/transaction_entity.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';
import 'package:pp_19/data/entity/wallet_entity.dart';

class DatabaseService {
  late final Box<dynamic> _common;
  late final Box<WalletEntity> _wallet;
  late final Box<Transaction> _transactions;
  late final Box<CourseCardEntity> _courses;

  Future<DatabaseService> init() async {
    await Hive.initFlutter();
    final appDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDirectory.path);

    Hive.registerAdapter(TransactionTypeAdapter());
    Hive.registerAdapter(CategoryItemAdapter());
    Hive.registerAdapter(TransactionAdapter());
    Hive.registerAdapter(WalletEntityAdapter());
    Hive.registerAdapter(LessonEntityAdapter());
    Hive.registerAdapter(QuizEntityAdapter());
    Hive.registerAdapter(CourseCardEntityAdapter());


    _common = await Hive.openBox('_common');
    _wallet = await Hive.openBox('_wallet');
    _transactions = await Hive.openBox('_transactions');
    _courses = await Hive.openBox('_courses');

    _transactions.clear();

    setupWallet();
    setupCourse();

    return this;
  }

  void setupCourse() {
    if (_courses.isEmpty) {
      final cards = ContentEmbedding.getCards;
        for (var card in cards) {
          _courses.put(cards.indexOf(card), card);
        }
    }
  }

  void setupWallet() {
    if (_wallet.isEmpty) {
      _wallet.put('mainWallet', WalletEntity(balance: 0));
    }
  }

  void finishTheQuiz(QuizEntity quiz, int progress) {
    CourseCardEntity selectedCard = _courses.values.firstWhere((element) => element.quizzes.contains(quiz));

    var quizzesCard = selectedCard.quizzes;

    var selectedQuiz = quizzesCard.firstWhere((element) => element == quiz);

    if (selectedQuiz.progress > progress) {
      return;
    }

    var updatedQuiz = selectedQuiz.copyWith(progress: progress);

    quizzesCard[quizzesCard.indexOf(selectedQuiz)] = updatedQuiz;

    var updatedSelectedCard = selectedCard.copyWith(quizzes: quizzesCard);

    updateCard(_courses.values.toList().indexOf(selectedCard), updatedSelectedCard);
  }

  void makeReadLesson(LessonEntity lesson) {
    CourseCardEntity selectedCard = _courses.values.firstWhere((element) => element.lessons.contains(lesson));

    var lessonsCard = selectedCard.lessons;

    var selectedLesson = lessonsCard.firstWhere((element) => element == lesson);

    var updatedLesson = selectedLesson.copyWith(isRead: true);

    lessonsCard[lessonsCard.indexOf(selectedLesson)] = updatedLesson;

    var updatedSelectedCard = selectedCard.copyWith(lessons: lessonsCard);

    updateCard(_courses.values.toList().indexOf(selectedCard), updatedSelectedCard);
  }

  void put(String key, dynamic value) => _common.put(key, value);

  dynamic get(String key) => _common.get(key);

  void updateWallet(dynamic value) => _wallet.put('mainWallet', value);

  WalletEntity getWallet() => _wallet.get('mainWallet')!;

  void addTransaction(Transaction value) => _transactions.add(value);

  List<Transaction> getTransactions() => _transactions.values.toList();

  List<CourseCardEntity> getCards() => _courses.values.toList();

  void updateCard(int index,CourseCardEntity card) => _courses.put(index, card);

  // LessonEntity getLesson({required int index}) => _lessons.get(index)!;
  //
  // void putLesson({required int index, required LessonEntity lesson}) => _lessons.put(index, lesson);
  //
  // QuizEntity getQuiz({required int index}) => _quizzes.get(index)!;
  //
  // void putQuiz({required int index, required QuizEntity quiz}) => _quizzes.put(index, quiz);
}
