import 'package:finplan/values/constants.dart';
import 'package:flutter/material.dart';




class MyThemes {
  static final darkTheme = ThemeData(
    
    primaryColor: FinPlanComplimentaryColor,
    scaffoldBackgroundColor: FinPlanDarkBackgroundColor,
    backgroundColor: FinPlanDarkBackgroundColor,
    colorScheme: ColorScheme.dark(
      primary: FinPlanComplimentaryColor,
      background: FinPlanDarkBackgroundColor,
      secondary: FinPlanDarkSecondayColor,
      
    ),
  );

  static final lightTheme = ThemeData(
    primaryColor: FinPlanColor,
    scaffoldBackgroundColor: FinPlanLightBackgroundColor,
    backgroundColor: FinPlanLightBackgroundColor,
    colorScheme: ColorScheme.light(
      primary: FinPlanColor,
      secondary: FinPlanLightSecondaryColor,
      background: FinPlanLightBackgroundColor,
    ),
  );
}

