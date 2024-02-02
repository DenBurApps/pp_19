import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.name,
    this.callback,
    required this.backgroundColor,
    required this.textColor,
    this.textStyle,
    this.width,
    this.borderRadius,
  });

  final String name;
  final VoidCallback? callback;
  final Color backgroundColor;
  final Color textColor;
  final TextStyle? textStyle;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 50,
      child: CupertinoButton(
        disabledColor: Theme.of(context).colorScheme.onBackground.withOpacity(0.5),
        color: backgroundColor,
        onPressed: callback,
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        child: Text(
          name,
          style: textStyle ?? Theme.of(context).textTheme.displayMedium!.copyWith(color: textColor),
        ),
      ),
    );
  }
}
