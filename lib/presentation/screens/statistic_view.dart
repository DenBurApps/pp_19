import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pp_19/business/controllers/statistic_controller.dart';
import 'package:pp_19/business/helpers/image/image_helper.dart';
import 'package:pp_19/business/helpers/month_enum.dart';
import 'package:pp_19/data/entity/transaction_entity.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/category_cover.dart';
import 'package:pp_19/presentation/widgets/date_switcher.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({super.key});

  @override
  State<StatisticView> createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> with TickerProviderStateMixin {
  final _statisticController = StatisticController();

  late final AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _statisticController.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: _statisticController,
          builder: (BuildContext context, StatisticControllerState state, Widget? child) {
            final Animation<double> incomeAnimation = Tween<double>(
              begin: state.oldIncome,
              end: state.newIncome,
            ).animate(controller);
        
            final Animation<double> outcomeAnimation = Tween<double>(
              begin: state.oldOutcome,
              end: state.newOutcome,
            ).animate(controller);
        
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(left: 0, right: 0, ),
                color: Theme.of(context).colorScheme.background,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Center(
                    child: Text('Statistic', style: Theme.of(context).textTheme.labelLarge),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: DateSwitcher(
                        selectedDate: _statisticController.activeDate,
                        increaseAction: () {
                          _statisticController.increaseMonth();
                          controller.reset();
                          controller.forward();
                        },
                        decreaseAction: () {
                          _statisticController.decreaseMonth();
                          controller.reset();
                          controller.forward();
                        },
                        isFirstShowType: false,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 272,
                    child: BarChartSample2(
                      monthName:
                          DateHelper.months[_statisticController.activeDate.month]!.substring(0, 3),
                      transactions: [...state.incomes, ...state.outcomes],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Overview', style: Theme.of(context).textTheme.labelMedium),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 131,
                            decoration: BoxDecoration(
                              color: Theme.of(context).extension<CustomColors>()!.incomeBg,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageHelper.svgImage(SvgNames.incomeIcon),
                                const SizedBox(height: 7),
                                Text('Income', style: Theme.of(context).textTheme.displayMedium),
                                FittedBox(
                                  child: AnimatedBuilder(
                                    animation: incomeAnimation,
                                    builder: (BuildContext context, Widget? child) {
                                      return Text('\$${incomeAnimation.value.toStringAsFixed(2)}',
                                          style: Theme.of(context).textTheme.labelLarge);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            height: 131,
                            decoration: BoxDecoration(
                              color: Theme.of(context).extension<CustomColors>()!.outcomeBg,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageHelper.svgImage(SvgNames.outcomeIcon),
                                const SizedBox(height: 7),
                                Text('Outcome', style: Theme.of(context).textTheme.displayMedium),
                                FittedBox(
                                  child: AnimatedBuilder(
                                    animation: outcomeAnimation,
                                    builder: (BuildContext context, Widget? child) {
                                      return Text(
                                        '\$${outcomeAnimation.value.toStringAsFixed(2)}',
                                        style: Theme.of(context).textTheme.labelLarge,
                                      );
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Favourite category', style: Theme.of(context).textTheme.labelMedium),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: 50,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          state.favoriteCategories.isEmpty
                              ? Text(
                                  'Please, add at least one transaction',
                                  style: Theme.of(context).textTheme.labelSmall,
                                )
                              : const SizedBox(),
                          ...state.favoriteCategories.map((e) => Container(
                                margin: const EdgeInsets.only(right: 25),
                                child: CategoryItemCover(
                                  color: Theme.of(context).extension<CustomColors>()!.outcomeBg!,
                                  assetPath: e,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15)
                ]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BarChartSample2 extends StatefulWidget {
  BarChartSample2({super.key, required this.monthName, required this.transactions});

  final String monthName;
  final List<Transaction> transactions;

  @override
  State<StatefulWidget> createState() => BarChartSample2State();
}

class BarChartSample2State extends State<BarChartSample2> {
  final double width = 18;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  double maxValue = 0;

  List<BarChartGroupData> _separateItems() {
    var result = <BarChartGroupData>[];

    double barIncomeGroup1 = 0.0;
    double barOutcomeGroup1 = 0.0;
    double barIncomeGroup2 = 0.0;
    double barOutcomeGroup2 = 0.0;
    double barIncomeGroup3 = 0.0;
    double barOutcomeGroup3 = 0.0;
    double barIncomeGroup4 = 0.0;
    double barOutcomeGroup4 = 0.0;
    double barIncomeGroup5 = 0.0;
    double barOutcomeGroup5 = 0.0;
    double barIncomeGroup6 = 0.0;
    double barOutcomeGroup6 = 0.0;

    for (var item in widget.transactions) {
      if (item.dateTime.day == 1) {
        if (item.type == TransactionType.income) {
          barIncomeGroup1 += item.amount;
        } else {
          barOutcomeGroup1 += item.amount;
        }
      } else if (item.dateTime.day > 1 && item.dateTime.day < 6) {
        if (item.type == TransactionType.income) {
          barIncomeGroup2 += item.amount;
        } else {
          barOutcomeGroup2 += item.amount;
        }
      } else if (item.dateTime.day > 5 && item.dateTime.day < 16) {
        if (item.type == TransactionType.income) {
          barIncomeGroup3 += item.amount;
        } else {
          barOutcomeGroup3 += item.amount;
        }
      } else if (item.dateTime.day > 15 && item.dateTime.day < 18) {
        if (item.type == TransactionType.income) {
          barIncomeGroup4 += item.amount;
        } else {
          barOutcomeGroup4 += item.amount;
        }
      } else if (item.dateTime.day > 17 && item.dateTime.day < 26) {
        if (item.type == TransactionType.income) {
          barIncomeGroup5 += item.amount;
        } else {
          barOutcomeGroup5 += item.amount;
        }
      } else if (item.dateTime.day > 25 && item.dateTime.day <= 31) {
        if (item.type == TransactionType.income) {
          barIncomeGroup6 += item.amount;
        } else {
          barOutcomeGroup6 += item.amount;
        }
      }
    }

    var columnList = [
      barIncomeGroup1,
      barOutcomeGroup1,
      barIncomeGroup2,
      barOutcomeGroup2,
      barIncomeGroup3,
      barOutcomeGroup3,
      barIncomeGroup4,
      barOutcomeGroup4,
      barIncomeGroup5,
      barOutcomeGroup5,
      barIncomeGroup6,
      barOutcomeGroup6,
    ];

    setState(() {
      maxValue = columnList.reduce(max);
      if (maxValue == 0) {
        maxValue = 1;
      }
    });

    var updatedColumns = [];

    for (var i = 0; i < columnList.length; i++) {
      updatedColumns.add(columnList[i] * 100 / maxValue);
    }

    result.addAll([
      makeGroupData(0, updatedColumns[0], updatedColumns[1]),
      makeGroupData(1, updatedColumns[2], updatedColumns[3]),
      makeGroupData(2, updatedColumns[4], updatedColumns[5]),
      makeGroupData(3, updatedColumns[6], updatedColumns[7]),
      makeGroupData(4, updatedColumns[8], updatedColumns[9]),
      makeGroupData(5, updatedColumns[10], updatedColumns[11]),
    ]);

    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final items = _separateItems();
    rawBarGroups = items;
    showingBarGroups = rawBarGroups;

    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 100,
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      tooltipBgColor: Colors.grey,
                      getTooltipItem: (a, b, c, d) => null,
                    ),
                    touchCallback: (FlTouchEvent event, response) {
                      if (response == null || response.spot == null) {
                        setState(() {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                        });
                        return;
                      }

                      touchedGroupIndex = response.spot!.touchedBarGroupIndex;

                      setState(() {
                        if (!event.isInterestedForInteractions) {
                          touchedGroupIndex = -1;
                          showingBarGroups = List.of(rawBarGroups);
                          return;
                        }
                        showingBarGroups = List.of(rawBarGroups);
                        if (touchedGroupIndex != -1) {
                          var sum = 0.0;
                          for (final rod in showingBarGroups[touchedGroupIndex].barRods) {
                            sum += rod.toY;
                          }
                          final avg = sum / showingBarGroups[touchedGroupIndex].barRods.length;

                          showingBarGroups[touchedGroupIndex] =
                              showingBarGroups[touchedGroupIndex].copyWith(
                            barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                              return rod.copyWith(
                                  toY: avg, color: Theme.of(context).colorScheme.onBackground);
                            }).toList(),
                          );
                        }
                      });
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: bottomTitles,
                        reservedSize: 55,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 65,
                        interval: 10,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  barGroups: showingBarGroups,
                  gridData: const FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    final style = Theme.of(context).textTheme.bodySmall;
    String text;
    if (value == 0) {
      text = '\$${(0).floor()}';
    } else if (value == 20) {
      text = '\$${(maxValue * 0.2).floor()}';
    } else if (value == 40) {
      text = '\$${(maxValue * 0.4).floor()}';
    } else if (value == 70) {
      text = '\$${(maxValue * 0.7).floor()}';
    } else if (value == 100) {
      text = '\$${maxValue.floor()}';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 1,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      (widget.monthName),
      (widget.monthName),
      (widget.monthName),
      (widget.monthName),
      (widget.monthName),
      (widget.monthName)
    ];

    final subTitles = <String>['1', '5', '15', '17', '25', '31'];

    final Widget text = Column(
      children: [
        Text(
          titles[value.toInt()],
          style: Theme.of(context).textTheme.displaySmall,
        ),
        Text(
          subTitles[value.toInt()],
          style: Theme.of(context).textTheme.displaySmall,
        )
      ],
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 2,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: const Color(0xFFE7F0FF),
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          color: const Color(0xFFE2DCFE),
          width: width,
        ),
      ],
    );
  }

  Widget makeTransactionsIcon() {
    const width = 4.5;
    const space = 3.5;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 42,
          color: Colors.white.withOpacity(1),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 28,
          color: Colors.white.withOpacity(0.8),
        ),
        const SizedBox(
          width: space,
        ),
        Container(
          width: width,
          height: 10,
          color: Colors.white.withOpacity(0.4),
        ),
      ],
    );
  }
}
