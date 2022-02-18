import 'package:finplan/values/constants.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme (bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    primaryColor: ComplimentaryColor,
    scaffoldBackgroundColor: DarkModeBackgroundColor,
    backgroundColor: DarkModeBackgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DarkModeSecondaryColor,
      unselectedItemColor: DarkModeAllBlackColor,
    ),
    secondaryHeaderColor: DarkModeSecondaryColor,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(

        foregroundColor: MaterialStateProperty.all<Color>(ComplimentaryColor),
      ),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: ComplimentaryColor),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      iconColor: ComplimentaryColor,
      labelStyle: TextStyle(
        color: ComplimentaryColor,
        fontSize: 15,
      ),
      hintStyle: TextStyle(
        color: ComplimentaryColor,
        fontSize: 15,
      ),
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: ComplimentaryColor,
      foregroundColor: DarkModeBackgroundColor,
      iconTheme: IconThemeData(color: DarkModeBackgroundColor),
    ),
  );

  static final lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: PrimaryColor,
      foregroundColor: LightModeBackgroundColor,
      iconTheme: IconThemeData(color: LightModeBackgroundColor),
    ),
    primaryColor: PrimaryColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: DarkModeAllBlackColor,
      unselectedItemColor: DarkModeSecondaryColor,
    ),
    scaffoldBackgroundColor: LightModeBackgroundColor,
    secondaryHeaderColor: LightModeSecondaryColor, 
    backgroundColor: LightModeBackgroundColor,
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(PrimaryColor),
      ),
    ),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: PrimaryColor),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      iconColor: PrimaryColor,
      labelStyle: TextStyle(
        color: PrimaryColor,
        fontSize: 15,
      ),
      hintStyle: TextStyle(
        color: PrimaryColor,
        fontSize: 15,
      ),
    ),
  );
}
