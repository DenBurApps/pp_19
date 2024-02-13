import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/wallet_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/app_button.dart';
import 'package:pp_19/presentation/widgets/transactions_list.dart';

class WalletView extends StatefulWidget {
  WalletView({super.key});

  @override
  State<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends State<WalletView> {
  final walletController = WalletController();

  final _budgetController = TextEditingController();

  void _editBudget(BuildContext context) {
    showCupertinoModalPopup(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        context: context,
        builder: (context) {
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
                  Row(
                    children: [
                      Text('Edit budget', style: Theme.of(context).textTheme.bodyMedium),
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: ImageHelper.svgImage(SvgNames.exit),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
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
                      controller: _budgetController,
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppButton(
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    callback: () {
                      walletController.changeBudget(double.parse(_budgetController.text));
                      Navigator.of(context).pop();
                      setState(() {});
                    },
                    width: double.infinity,
                    name: 'Save',
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    double number = walletController.balance;
    int wholePart = number.toInt();
    double fractionalPart = number - wholePart;
    if (fractionalPart == 0) {
      fractionalPart = 0.001;
    }

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: walletController,
            builder: (BuildContext context, WalletControllerState state, Widget? child) {
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                color: Theme.of(context).colorScheme.background,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                          child: Text('Wallet', style: Theme.of(context).textTheme.labelLarge),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Your budget', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 20),
                    Container(
                      height: 76,
                      padding: const EdgeInsets.only(top: 15, bottom: 15, left: 25, right: 20),
                      decoration: BoxDecoration(
                          color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        children: [
                          Text.rich(TextSpan(
                              text: '\$$wholePart.',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(fontSize: 40, fontWeight: FontWeight.w700),
                              children: [
                                TextSpan(
                                    text: fractionalPart.toString().split('.')[1].substring(0, 2),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600))
                              ])),
                          const Spacer(),
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => _editBudget(context),
                            child: ImageHelper.svgImage(SvgNames.note),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Add income/expenses', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(20),
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageHelper.svgImage(SvgNames.incomeIcon),
                                const SizedBox(height: 27),
                                Text('Income', style: Theme.of(context).textTheme.labelLarge)
                              ],
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(
                                RouteNames.newTransaction,
                                arguments: TransactionType.income),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.all(20),
                            borderRadius: BorderRadius.circular(30),
                            color: Theme.of(context).extension<CustomColors>()!.outcomeBg,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ImageHelper.svgImage(SvgNames.outcomeIcon),
                                const SizedBox(height: 27),
                                Text('Outcome', style: Theme.of(context).textTheme.labelLarge)
                              ],
                            ),
                            onPressed: () => Navigator.of(context).pushNamed(
                                RouteNames.newTransaction,
                                arguments: TransactionType.outcome),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Last operation', style: Theme.of(context).textTheme.labelMedium),
                    const SizedBox(height: 20),
                    TransactionsList(
                      transactions: state.allTransactions,
                      darkMode: true,
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
