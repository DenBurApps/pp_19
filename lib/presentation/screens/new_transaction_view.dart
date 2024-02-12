import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pp_19/business/controllers/wallet_controller.dart';
import 'package:pp_19/business/helpers/category_enum.dart';
import 'package:pp_19/business/helpers/extensions/string_extension.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/entity/category_item.dart';
import 'package:pp_19/data/entity/transaction_entity.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/app_button.dart';

class NewTransactionView extends StatefulWidget {
  const NewTransactionView({super.key, required this.transactionType});

  final TransactionType transactionType;

  @override
  State<NewTransactionView> createState() => _NewTransactionViewState();
}

class _NewTransactionViewState extends State<NewTransactionView> {
  late Map<String, List<String>> items = {};
  DateTime _dateTime = DateTime.now();

  final _nameController = TextEditingController();
  final _countController = TextEditingController();
  final _dateTimeController = TextEditingController();

  final _walletController = WalletController();

  String selectedIconPath = '';

  // final DateFormat formatter = DateFormat('dd.MM.yy HH:mm');

  void changeIconPath(String path) {
    setState(() {
      selectedIconPath = path;
    });
  }

  void setDateTime(DateTime newDateTime) {
    setState(() {
      _dateTime = newDateTime;
    });
  }

  void generateItems() {
    for (var category in CategoryEnum.values) {
      items.addAll({
        category.categoryName: [
          'assets/icons/${category.categoryName}_1.svg',
          'assets/icons/${category.categoryName}_2.svg',
          'assets/icons/${category.categoryName}_3.svg',
          'assets/icons/${category.categoryName}_4.svg',
          'assets/icons/${category.categoryName}_5.svg',
        ]
      });
    }
  }

  void _save() {
    Navigator.of(context).pop();

    if (double.parse(_countController.text) < 0.01 ||
        double.parse(_countController.text) > 9999999) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: const Text("Incorrect amount"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      );
      return;
    }

    if (_nameController.text.isEmpty) {
      showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Error'),
          content: const Text("Cannot create a transaction without name"),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Try again'),
            ),
          ],
        ),
      );
      return;
    }

    final transaction = Transaction(
      name: _nameController.text,
      amount: double.parse(_countController.text),
      type: widget.transactionType,
      dateTime: _dateTime,
      category: CategoryItem(name: _nameController.text, svgPath: selectedIconPath),
    );
    _walletController.addTransaction(transaction);
    Navigator.of(context).pushReplacementNamed(RouteNames.main);
  }

  void _addTransaction(BuildContext context, String path) {
    changeIconPath(path);

    var _dateTimeDouble = DateTime.now();


    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    )),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: ImageHelper.svgImage(SvgNames.exit),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Text('Enter count’s', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 76,
                      child: CupertinoTextField(
                        keyboardType: TextInputType.number,
                        scrollPadding: EdgeInsets.zero,
                        maxLines: 1,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        cursorColor: Theme.of(context).colorScheme.onBackground,
                        decoration: BoxDecoration(
                            color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                            borderRadius: BorderRadius.circular(10)),
                        style: Theme.of(context).textTheme.bodyLarge,
                        placeholder: 'Enter new count...',
                        placeholderStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                        controller: _countController,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Enter data', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 15),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _showDateTimeDialog(
                        CupertinoDatePicker(
                          initialDateTime: DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          showDayOfWeek: false,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() {
                              _dateTimeDouble = newDate;
                            });
                            setDateTime(newDate);
                          },
                        ),
                      ),
                      child: Container(
                          height: 76,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  '${_dateTimeDouble.day}.${_dateTimeDouble.month}.${_dateTimeDouble.year}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: Theme.of(context).colorScheme.onBackground),
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ImageHelper.svgImage(SvgNames.calendar,
                                    color: Colors.black, height: 21, width: 25),
                              ),
                            ],
                          )),
                    ),
                    const SizedBox(height: 20),
                    Text('Enter name', style: Theme.of(context).textTheme.bodyMedium),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 76,
                      child: CupertinoTextField(
                        keyboardType: TextInputType.name,
                        scrollPadding: EdgeInsets.zero,
                        maxLines: 1,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                        cursorColor: Theme.of(context).colorScheme.onBackground,
                        decoration: BoxDecoration(
                            color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                            borderRadius: BorderRadius.circular(10)),
                        style: Theme.of(context).textTheme.bodyLarge,
                        placeholder: 'Enter new name...',
                        placeholderStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                        controller: _nameController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    AppButton(
                      textStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      callback: _save,
                      width: double.infinity,
                      name: 'Save',
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  void _showDateTimeDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  void initState() {
    generateItems();
    super.initState();
  }

  @override
  void dispose() {
    _walletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        color: Theme.of(context).colorScheme.background,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: ImageHelper.svgImage(SvgNames.chevronLeft),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 50),
                  child: Text(widget.transactionType == TransactionType.income ? 'Income' : 'Outcome',
                      style: Theme.of(context).textTheme.labelLarge),
                ),
                const Spacer(),
              ],
            ),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: items
                    .map(
                      (key, value) => MapEntry(
                        key,
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                key.capitalize,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(color: Theme.of(context).colorScheme.onBackground),
                              ),
                              const SizedBox(height: 17),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var icon in items[key]!)
                                    CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () => _addTransaction(context, icon),
                                      child: IconContainer(
                                        transactionType: widget.transactionType,
                                        svgPath: icon,
                                        isSelected: icon == selectedIconPath,
                                      ),
                                    )
                                ],
                              ),
                              const SizedBox(height: 29)
                            ],
                          ),
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.svgPath,
    required this.isSelected,
    required this.transactionType,
  });

  final String svgPath;
  final bool isSelected;
  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(
        color: transactionType == TransactionType.income
            ? Theme.of(context).extension<CustomColors>()!.incomeBg
            : Theme.of(context).extension<CustomColors>()!.outcomeBg,
        borderRadius: BorderRadius.circular(100),
        border: isSelected
            ? Border.all(width: 2, color: Theme.of(context).colorScheme.onBackground)
            : null,
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: 25,
          height: 25,
          fit: BoxFit.none,
        ),
      ),
    );
  }
}
