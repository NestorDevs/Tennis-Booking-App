import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[100],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(
      secondary: Colors.blueAccent,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.light().textTheme.apply(
            bodyColor: Colors.black,
            displayColor: Colors.black,
          ),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: Colors.white,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.black,
      subtitleTextStyle: TextStyle(color: Colors.black54),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
        .copyWith(
      secondary: Colors.amberAccent,
      brightness: Brightness.dark,
      primary: Colors.deepPurple[700],
      onPrimary: Colors.white,
      secondaryContainer: Colors.amber[700],
      onSecondaryContainer: Colors.black,
      surface: Colors.grey[850],
      onSurface: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.montserratTextTheme(
      ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
    ),
    cardTheme: CardThemeData(
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: Colors.grey[850],
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      subtitleTextStyle: TextStyle(color: Colors.white70),
    ),
  );
}
