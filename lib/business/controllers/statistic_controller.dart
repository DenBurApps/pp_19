import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_19/business/controllers/date_switcher_controller.dart';
import 'package:pp_19/data/database/database_service.dart';
import 'package:pp_19/data/entity/transaction_entity.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';

class StatisticController extends ValueNotifier<StatisticControllerState> {
  StatisticController() : super(StatisticControllerState.initial()) {
    initialize();
  }

  final dataBase = GetIt.I.get<DatabaseService>();
  final dateSwitchController = DateSwitchController();

  DateTime get activeDate => dateSwitchController.activeDate;

  void initialize() {
    updatePostList();
    countFavoriteCategories();
  }


  void countFavoriteCategories() {
    Map<String, int> pathCountMap = {};

    final transactions = dataBase.getTransactions();

    for (Transaction transaction in transactions) {
      String path = transaction.category.svgPath;

      if (pathCountMap.containsKey(path)) {
        pathCountMap[path] = pathCountMap[path]! + 1;
      } else {
        pathCountMap[path] = 1;
      }
    }

    List<MapEntry<String, int>> sortedEntries = pathCountMap.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    List<Map<String, int>> result = sortedEntries.map((entry) => {entry.key: entry.value}).toList();

    if (sortedEntries.length > 4) {
      List<String> sortedPaths = sortedEntries.sublist(0, 5).map((entry) => entry.key).toList();
      value = value.copyWith(favoriteCategories: sortedPaths);
    } else {
      List<String> sortedPaths = sortedEntries.map((entry) => entry.key).toList();
      value = value.copyWith(favoriteCategories: sortedPaths);
    }
  }

  void updatePostList() {
    var incomes = <Transaction>[];
    var outcomes = <Transaction>[];
    var updatedPostsFromDate = <Transaction>[];
    double oldIncome = 0;
    double newIncome = 0;
    double oldOutcome = 0;
    double newOutcome = 0;

    final postList = dataBase.getTransactions();

    for (var post in postList) {
      if (post.dateTime.month == dateSwitchController.activeDate.month &&
          post.dateTime.year == dateSwitchController.activeDate.year) {
        updatedPostsFromDate.add(post);
        if (post.type == TransactionType.income) {
          incomes.add(post);
          newIncome += post.amount;
        }
        if (post.type == TransactionType.outcome) {
          outcomes.add(post);
          newOutcome += post.amount;
        }
      }
    }

    oldIncome = value.newIncome;
    oldOutcome = value.newOutcome;

    value = value.copyWith(
      incomes: incomes,
      outcomes: outcomes,
      newIncome: newIncome,
      oldIncome: oldIncome,
      newOutcome: newOutcome,
      oldOutcome: oldOutcome,
    );
    notifyListeners();
  }

  void increaseMonth() {
    dateSwitchController.increaseMonth();
    notifyListeners();
    updatePostList();
  }

  void decreaseMonth() {
    dateSwitchController.decreaseMonth();
    notifyListeners();
    updatePostList();
  }
}

class StatisticControllerState {
  final List<Transaction> incomes;
  final List<Transaction> outcomes;
  final double oldIncome;
  final double newIncome;
  final double oldOutcome;
  final double newOutcome;
  final List<String> favoriteCategories;

  StatisticControllerState(
      {required this.incomes,
      required this.outcomes,
      required this.oldIncome,
      required this.newIncome,
      required this.oldOutcome,
      required this.newOutcome,
      required this.favoriteCategories});

  factory StatisticControllerState.initial() {
    return StatisticControllerState(
      incomes: [],
      outcomes: [],
      oldIncome: 0,
      newIncome: 0,
      oldOutcome: 0,
      newOutcome: 0,
      favoriteCategories: [],
    );
  }

  StatisticControllerState copyWith({
    List<Transaction>? incomes,
    List<Transaction>? outcomes,
    double? oldIncome,
    double? newIncome,
    double? oldOutcome,
    double? newOutcome,
    List<String>? favoriteCategories,
  }) {
    return StatisticControllerState(
      incomes: incomes ?? this.incomes,
      outcomes: outcomes ?? this.outcomes,
      oldIncome: oldIncome ?? this.oldIncome,
      newIncome: newIncome ?? this.newIncome,
      oldOutcome: oldOutcome ?? this.oldOutcome,
      newOutcome: newOutcome ?? this.newOutcome,
      favoriteCategories: favoriteCategories ?? this.favoriteCategories,
    );
  }
}
