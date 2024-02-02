import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pp_19/presentation/themes/custom_colors.dart';


class DefaultThemeGetter {
  static ThemeData get() {
    const primary = Color(0xFFFF4B00);
    const primaryLight = Colors.black;
    const primaryDark = Colors.black;
    const onBackground = Colors.black;
    const surface = Color(0xFFFEFEFE);
    const customColorsExtension = CustomColors.light;

    return ThemeData(
      primaryColor: primary,
      primaryColorLight: primaryLight,
      primaryColorDark: primaryDark,
      textTheme: TextTheme(
        headlineLarge: GoogleFonts.tourney(
          fontWeight: FontWeight.w800,
          fontSize: 36.0,
          height: 1.2,
        ),
        bodyLarge: GoogleFonts.workSans(
          fontWeight: FontWeight.w400,
          fontSize: 20.0,
          height: 1.2,
        ),
        bodyMedium: GoogleFonts.workSans(
          fontWeight: FontWeight.w800,
          fontSize: 16.0,
          height: 1.2,
        ),
        displayLarge: GoogleFonts.workSans(
          fontWeight: FontWeight.w700,
          fontSize: 40.0,
          height: 1.2,
          letterSpacing: -0.165
        ),
        displayMedium: GoogleFonts.workSans(
          fontWeight: FontWeight.w900,
          fontSize: 14.0,
          height: 1.2,
        ),
        displaySmall: GoogleFonts.workSans(
          fontWeight: FontWeight.w400,
          fontSize: 10.0,
          height: 1.2,
        ),
        headlineMedium: GoogleFonts.tourney(
          fontWeight: FontWeight.w500,
          fontSize: 22.0,
          height: 1.1,
        ),
        titleMedium: GoogleFonts.tourney(
          fontWeight: FontWeight.w400,
          fontSize: 15.0,
          height: 1.0,
        ),
        titleSmall: GoogleFonts.tourney(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          height: 1.0,
        ),
        titleLarge: GoogleFonts.tourney(
          fontWeight: FontWeight.w500,
          fontSize: 20.0,
          height: 1.0,
        ),
        labelSmall: GoogleFonts.workSans(
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          height: 1.2,
        ),
        labelMedium: GoogleFonts.workSans(
          fontWeight: FontWeight.w600,
          fontSize: 20.0,
          height: 1.2,
        ),
        labelLarge: GoogleFonts.workSans(
          fontWeight: FontWeight.w700,
          fontSize: 25.0,
          height: 1.2,
          letterSpacing: 0.5,
        ),
        bodySmall: GoogleFonts.workSans(
          fontWeight: FontWeight.w500,
          fontSize: 12.0,
          height: 1.2,
        ),
      ).apply(
        bodyColor: onBackground,
        displayColor: onBackground,
      ),
      appBarTheme: const AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(
            const Size(
              double.infinity,
              48.0,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
              if (states.contains(MaterialState.disabled)) {
                return primary.withOpacity(0.3);
              }
              return primary;
            },
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            minimumSize: MaterialStateProperty.all(
              const Size(
                double.infinity,
                53.0,
              ),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            side: MaterialStateProperty.all(
              const BorderSide(color: primary),
            )),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        customColorsExtension,
      ],
      colorScheme: const ColorScheme(
        primary: primary,
        primaryContainer: primaryDark,
        secondary: Color(0xFF111315),
        surface: surface,
        onSurface: Colors.black,
        background: Color(0xFFFEFEFE),
        secondaryContainer: Color(0xFF34C85A),
        onBackground: onBackground,
        error: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
        onPrimary: Colors.white,
        onSecondary: Color(0xFF0D0D0D),
      ),
    );
  }
}
