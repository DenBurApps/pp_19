import 'package:hive/hive.dart';

part 'wallet_entity.g.dart';

@HiveType(typeId: 5)
class WalletEntity {
  @HiveField(0)
  late final double balance;

  WalletEntity({required this.balance});

  WalletEntity copyWith({double? balance}) => WalletEntity(balance: balance ?? this.balance);
}
