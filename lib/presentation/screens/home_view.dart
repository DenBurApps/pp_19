import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_19/business/controllers/wallet_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/services/navigation/route_names.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/date_switcher.dart';
import 'package:pp_19/presentation/widgets/transactions_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  final WalletController walletController = WalletController();

  @override
  void dispose() {
    walletController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: walletController,
          builder: (BuildContext context, WalletControllerState state, Widget? child) {
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              color: Theme.of(context).colorScheme.background,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Check your balance',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                  ),
                  const SizedBox(height: 20),
                  WalletWidget(
                    controller: walletController,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Your subscriptions', style: Theme.of(context).textTheme.labelMedium),
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Text(
                          'See all',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        onPressed: () => Navigator.of(context).pushNamed(RouteNames.transactions),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  DateSwitcher(
                    isFirstShowType: true,
                    selectedDate: walletController.activeDate,
                    increaseAction: () => walletController.increaseMonth(),
                    decreaseAction: () => walletController.decreaseMonth(),
                  ),
                  const SizedBox(height: 20),
                  TransactionsList(
                    transactions: state.filteredTransactions,
                    darkMode: true,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }),
    );
  }
}

class WalletWidget extends StatefulWidget {
  const WalletWidget({
    super.key,
    required this.controller,
  });

  final WalletController controller;

  @override
  State<WalletWidget> createState() => _WalletWidgetState();
}

class _WalletWidgetState extends State<WalletWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double number = widget.controller.balance;
    int wholePart = number.toInt();
    double fractionalPart = number - wholePart;
    if (fractionalPart == 0) {
      fractionalPart = 0.001;
    }

    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (BuildContext context, WalletControllerState state, Widget? child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).extension<CustomColors>()!.lighterBlack,
            borderRadius: BorderRadius.circular(21),
          ),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Theme.of(context).extension<CustomColors>()!.walletBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageHelper.svgImage(SvgNames.wallet),
                      const SizedBox(width: 10),
                      Text(
                        'Subscription’s wallet',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5)),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => Navigator.of(context).pushNamed(RouteNames.wallet).then(
                              (value) => widget.controller.updateBalance(),
                            ),
                        child: ImageHelper.svgImage(SvgNames.note),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
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
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  onPressed: state.allTransactions.isEmpty
                      ? null
                      : state.activeTab == 1
                          ? widget.controller.toggleTab
                          : null,
                  child: Row(
                    children: [
                      ImageHelper.svgImage(SvgNames.income),
                      const SizedBox(width: 7),
                      Text(
                        'Income',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 26,
                  child: VerticalDivider(
                    width: 1,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                CupertinoButton(
                  onPressed: state.allTransactions.isEmpty
                      ? null
                      : state.activeTab == 0
                      ? widget.controller.toggleTab
                      : null,
                  child: Row(
                    children: [
                      ImageHelper.svgImage(SvgNames.outcome),
                      const SizedBox(width: 7),
                      Text(
                        'Costs',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10)
          ]),
        );
      },
    );
  }
}
