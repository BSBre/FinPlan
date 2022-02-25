import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/screens/home/homeScreen.dart';
import 'package:finplan/screens/intro/intro_screen.dart';
import 'package:finplan/screens/navigation/calendarPage.dart';
import 'package:finplan/screens/navigation/paymentPage.dart';
import 'package:finplan/screens/navigation/profilePage.dart';
import 'package:finplan/screens/registration/passwordResetScreen.dart';
import 'package:finplan/screens/registration/signInScreen.dart';
import 'package:finplan/screens/registration/signUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:finplan/values/constants.dart';

class AppRouter {
  UserAuth userAuth;
  AppRouter({required this.userAuth});
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SignInPageRoute:
        return MaterialPageRoute(builder: (_) => SignInPage(userAuth: userAuth,));
      case SignUpPageRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage(userAuth: userAuth,));
      case HomePageRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
       case CalendarPageRoute:
        return MaterialPageRoute(builder: (_) => CalendarPage());
      case PaymentPageRoute:
        return MaterialPageRoute(builder: (_) => PaymentPage());
      case IntroScreenRoute:
        return MaterialPageRoute(builder: (_) => IntroScreen());
      case ProfilePageRoute:
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case PasswordResetScreenRoute:
        return MaterialPageRoute(builder: (_) => PasswordResetScreen());
      default:
        return _errorRoute();
    }
  }

  void dispose() {}

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('Error'),
          ),
        );
      },
    );
  }
}
