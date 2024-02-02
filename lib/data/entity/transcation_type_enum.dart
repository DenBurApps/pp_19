import 'package:hive/hive.dart';

part 'transcation_type_enum.g.dart';

@HiveType(typeId: 1)
enum TransactionType {
  @HiveField(0) income,
  @HiveField(1) outcome,
}