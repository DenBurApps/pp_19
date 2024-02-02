import 'package:flutter/cupertino.dart';

class DateSwitchController extends ValueNotifier<DateSwitchControllerState> {
  DateSwitchController() : super(DateSwitchControllerState.initial());

  DateTime get activeDate => value.activeDate;

  void increaseMonth() {
    var updatedDate = value.activeDate.copyWith(month: value.activeDate.month + 1);
    value = value.copyWith(activeDate: updatedDate);
    notifyListeners();
  }

  void decreaseMonth() {
    var updatedDate = value.activeDate.copyWith(month: value.activeDate.month - 1);
    value = value.copyWith(activeDate: updatedDate);
    notifyListeners();
  }
}

class DateSwitchControllerState {
  final DateTime activeDate;

  DateSwitchControllerState({
    required this.activeDate,
  });

  factory DateSwitchControllerState.initial() {
    return DateSwitchControllerState(
      activeDate: DateTime.now(),
    );
  }

  DateSwitchControllerState copyWith({
    DateTime? activeDate,
  }) {
    return DateSwitchControllerState(
      activeDate: activeDate ?? this.activeDate,
    );
  }
}
