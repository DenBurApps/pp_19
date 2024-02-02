import 'package:hive_flutter/hive_flutter.dart';

part 'category_item.g.dart';

@HiveType(typeId: 3)
class CategoryItem extends HiveObject {
  CategoryItem({required this.name, required this.svgPath});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String svgPath;
}