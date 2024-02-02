import 'package:flutter/material.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  const CustomColors({
    this.background,
    this.grey,
    this.blue,
    this.green,
    this.red,
    this.lighterBlack,
    this.walletBg,
    this.incomeBg,
    this.outcomeBg,
    this.cyan,
    this.lightGrey,
    this.darkRed,
  });

  final Color? background;
  final Color? grey;
  final Color? blue;
  final Color? green;
  final Color? red;
  final Color? lighterBlack;
  final Color? walletBg;
  final Color? incomeBg;
  final Color? outcomeBg;
  final Color? cyan;
  final Color? lightGrey;
  final Color? darkRed;

  @override
  CustomColors copyWith({
    Color? background,
    Color? grey,
    Color? blue,
    Color? green,
    Color? red,
    Color? lighterBlack,
    Color? walletBg,
    Color? incomeBg,
    Color? outcomeBg,
    Color? cyan,
    Color? lightGrey,
    Color? darkRed,
  }) {
    return CustomColors(
      background: background ?? this.background,
      grey: grey ?? this.grey,
      blue: blue ?? this.blue,
      green: green ?? this.green,
      red: red ?? this.red,
      lighterBlack: lighterBlack ?? this.lighterBlack,
      walletBg: walletBg ?? this.walletBg,
      incomeBg: incomeBg ?? this.incomeBg,
      outcomeBg: outcomeBg ?? this.outcomeBg,
      cyan: cyan ?? this.cyan,
      lightGrey: lightGrey ?? this.lightGrey,
      darkRed: darkRed ?? this.darkRed,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      background: Color.lerp(background, other.background, t)!,
      grey: Color.lerp(grey, other.grey, t)!,
      blue: Color.lerp(blue, other.blue, t)!,
      green: Color.lerp(green, other.green, t)!,
      red: Color.lerp(red, other.red, t)!,
      lighterBlack: Color.lerp(lighterBlack, other.lighterBlack, t)!,
      walletBg: Color.lerp(walletBg, other.walletBg, t)!,
      incomeBg: Color.lerp(incomeBg, other.incomeBg, t)!,
      outcomeBg: Color.lerp(outcomeBg, other.outcomeBg, t)!,
      cyan: Color.lerp(cyan, other.cyan, t)!,
      lightGrey: Color.lerp(lightGrey, other.lightGrey, t)!,
      darkRed: Color.lerp(darkRed, other.darkRed, t)!,
    );
  }

  static const light = CustomColors(
    background: Color(0xFFFEFEFE),
    grey: Color(0xFF323232),
    blue: Color(0xFF223752),
    green: Color(0xFFE5FEDC),
    red: Color(0xFFFEDCDC),
    lighterBlack: Color(0xFF111111),
    walletBg: Color(0xFFE7F0FF),
    incomeBg: Color(0xFFE7F0FF),
    outcomeBg: Color(0xFFE2DCFE),
    cyan: Color(0xFF71E9AF),
    lightGrey: Color(0xFFEEF0F7),
    darkRed: Color(0xFFE97171),
  );
}
