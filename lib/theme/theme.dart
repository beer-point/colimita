import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme();

  static ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.light().copyWith(
        primary: Colors.amber[800],
        secondary: Colors.white,
        secondaryVariant: Colors.amber,
      ),
      fontFamily: GoogleFonts.roboto().fontFamily,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          primary: Colors.amber,
        ),
      ),
      iconTheme: const IconThemeData(size: 32),
      textTheme: const TextTheme(
        button: TextStyle(color: Colors.white),
        headline1: TextStyle(color: Colors.black),
        headline4: TextStyle(color: Colors.black),
        headline6: TextStyle(color: Colors.black),
        bodyText1: TextStyle(color: Colors.black),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.amber,
      )
      //   padding: EdgeInsets.all(20),
      //   textTheme:ButtonTextTheme.primary
      // ),
      );

  static ThemeData darkTheme = ThemeData(
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light().copyWith(
      primary: const Color(0xff1536f1),
      secondary: Colors.white,
    ),
    fontFamily: GoogleFonts.roboto().fontFamily,
  );

  static const double outerMargin = 16.0;
  static const double padding = 8.0;

  static EdgeInsets marginPadding =
      const EdgeInsets.symmetric(horizontal: outerMargin, vertical: padding);
  static EdgeInsets horizontalPadding =
      const EdgeInsets.symmetric(horizontal: padding);
  static EdgeInsets verticalPadding =
      const EdgeInsets.symmetric(vertical: padding);
  static EdgeInsets allPadding = const EdgeInsets.all(padding);
}
