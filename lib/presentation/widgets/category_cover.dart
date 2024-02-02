import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryItemCover extends StatelessWidget {
  const CategoryItemCover({super.key, required this.color, required this.assetPath});

  final Color color;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: SvgPicture.asset(
          assetPath,
          width: 25,
          height: 25,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
