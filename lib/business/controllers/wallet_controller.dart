import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:pp_19/business/controllers/date_switcher_controller.dart';
import 'package:pp_19/data/database/database_service.dart';
import 'package:pp_19/data/entity/transaction_entity.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';

class WalletController extends ValueNotifier<WalletControllerState> {
  WalletController() : super(WalletControllerState.initial()) {
    initialize();
  }

  final dataBase = GetIt.I.get<DatabaseService>();
  final dateSwitchController = DateSwitchController();

  DateTime get activeDate => dateSwitchController.activeDate;

  double get balance => value.balance;

  int get activeTab => value.activeTab;

  List<Transaction> get filteredPosts => value.filteredTransactions;

  void addTransaction(Transaction transaction) {
    dataBase.addTransaction(transaction);
    addBalance(
        transaction.type == TransactionType.income ? transaction.amount : -transaction.amount);
  }

  void addBalance(double amount) {
    final wallet = dataBase.getWallet();
    final updatedBalance = wallet.balance + amount;

    dataBase.updateWallet(wallet.copyWith(balance: updatedBalance));
    notifyListeners();
  }

  void changeBudget(double amount) {
    final updatedWallet = dataBase.getWallet().copyWith(balance: amount);
    dataBase.updateWallet(updatedWallet);
    value = value.copyWith(balance: amount);
    notifyListeners();
  }

  void updateBalance() {
    final balance = dataBase.getWallet().balance;
    value = value.copyWith(balance: balance);
    notifyListeners();
  }

  void initialize() {
    updatePostList();
    updateBalance();
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

  void toggleTab() {
    if (activeTab == 0) {
      value = value.copyWith(activeTab: 1);
    } else {
      value = value.copyWith(activeTab: 0);
    }
    notifyListeners();
    updatePostList();
  }

  void updatePostList() {
    var updatedPosts = <Transaction>[];
    var updatedPostsFromDate = <Transaction>[];

    final postList = dataBase.getTransactions();

    for (var post in postList) {
      if (post.dateTime.month == dateSwitchController.activeDate.month &&
          post.dateTime.year == dateSwitchController.activeDate.year) {
        updatedPostsFromDate.add(post);
        if (activeTab == 0) {
          if (post.type == TransactionType.income) {
            updatedPosts.add(post);
          }
        } else {
          if (post.type == TransactionType.outcome) {
            updatedPosts.add(post);
          }
        }
      }
    }

    value =
        value.copyWith(filteredTransactions: updatedPosts, allTransactions: updatedPostsFromDate);
    notifyListeners();
  }
}

class WalletControllerState {
  final int activeTab;
  final List<Transaction> filteredTransactions;
  final double balance;
  final List<Transaction> allTransactions;

  WalletControllerState({
    required this.activeTab,
    required this.filteredTransactions,
    required this.balance,
    required this.allTransactions,
  });

  factory WalletControllerState.initial() {
    return WalletControllerState(
      activeTab: 0,
      filteredTransactions: [],
      balance: 0.0,
      allTransactions: [],
    );
  }

  WalletControllerState copyWith({
    int? activeTab,
    List<Transaction>? filteredTransactions,
    double? balance,
    List<Transaction>? allTransactions,
  }) {
    return WalletControllerState(
      activeTab: activeTab ?? this.activeTab,
      filteredTransactions: filteredTransactions ?? this.filteredTransactions,
      balance: balance ?? this.balance,
      allTransactions: allTransactions ?? this.allTransactions,
    );
  }
}
