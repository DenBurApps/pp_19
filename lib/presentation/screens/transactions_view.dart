import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/wallet_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/presentation/widgets/date_switcher.dart';
import 'package:pp_19/presentation/widgets/transactions_list.dart';

class TransactionsView extends StatefulWidget {
 const  TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  final walletController = WalletController();

  @override
  void dispose() {
    walletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                children: [
                  Row(
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: ImageHelper.svgImage(SvgNames.chevronLeft),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Spacer(),
                      Text.rich(
                        TextSpan(
                          text: 'All subscriptions\n',
                          style: Theme.of(context).textTheme.labelLarge,
                          children: [
                            TextSpan(
                              text: 'Check your subscriptions',
                              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DateSwitcher(
                    isFirstShowType: false,
                    selectedDate: walletController.activeDate,
                    increaseAction: () => walletController.increaseMonth(),
                    decreaseAction: () => walletController.decreaseMonth(),
                  ),
                  const SizedBox(height: 10),
                  TransactionsList(
                    transactions: state.allTransactions,
                    darkMode: false,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
