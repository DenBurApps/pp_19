import 'package:flutter/material.dart';
import 'package:pp_19/business/helpers/date_parser.dart';
import 'package:pp_19/data/entity/transaction_entity.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';
import 'package:pp_19/presentation/widgets/category_cover.dart';

class TransactionsList extends StatelessWidget {
  const TransactionsList({
    super.key,
    required this.transactions,
    required this.darkMode,
  });

  final List<Transaction> transactions;
  final bool darkMode;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: darkMode ? const EdgeInsets.symmetric(horizontal: 10) : null,
        decoration: BoxDecoration(
            color: darkMode ? Theme.of(context).extension<CustomColors>()!.lighterBlack : null,
            borderRadius: BorderRadius.circular(20)),
        child: transactions.isNotEmpty
            ? SizedBox(
                height: 175,
                child: ListView(
                  shrinkWrap: true,
                  children: [...transactions.reversed.map((e) => TransactionContainer(transaction: e))],
                ),
              )
            : Center(
                child: Text(
                  'Enter your first transaction',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
      ),
    );
  }
}

class TransactionContainer extends StatelessWidget {
  const TransactionContainer({super.key, required this.transaction});

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: transaction.type == TransactionType.income
            ? Theme.of(context).extension<CustomColors>()!.incomeBg
            : Theme.of(context).extension<CustomColors>()!.outcomeBg,
      ),
      child: ListTile(
        leading: CategoryItemCover(
            color: Theme.of(context).colorScheme.onPrimary,
            assetPath: transaction.category.svgPath),
        title: Text(
          transaction.category.name,
          style: Theme.of(context)
              .textTheme
              .labelMedium!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        subtitle: Text(
          DateParser.parseDate(dateTime: transaction.dateTime),
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
        trailing: Text(
          '${transaction.type == TransactionType.income ? '+' : '-'}${transaction.amount.toString()}\$',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
