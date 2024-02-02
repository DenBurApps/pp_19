import 'package:hive/hive.dart';
import 'package:pp_19/data/entity/category_item.dart';
import 'package:pp_19/data/entity/transcation_type_enum.dart';

part 'transaction_entity.g.dart';

@HiveType(typeId: 0)
class Transaction {
  @HiveField(0)
  late final String name;
  @HiveField(1)
  late final double amount;
  @HiveField(2)
  late final TransactionType type;
  @HiveField(3)
  late final DateTime dateTime;
  @HiveField(4)
  late final CategoryItem category;

  Transaction(
      {required this.name,
      required this.amount,
      required this.type,
      required this.dateTime,
      required this.category});

  Transaction copyWith(
          {String? name,
          double? amount,
          TransactionType? type,
          DateTime? dateTime,
          CategoryItem? category}) =>
      Transaction(
        name: name ?? this.name,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        dateTime: dateTime ?? this.dateTime,
        category: category ?? this.category,
      );
}
