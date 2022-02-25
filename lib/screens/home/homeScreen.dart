import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finplan/screens/navigation/calendarPage.dart';
import 'package:finplan/screens/navigation/homePage.dart';
import 'package:finplan/screens/navigation/notificationPage.dart';
import 'package:finplan/screens/navigation/paymentPage.dart';
import 'package:finplan/screens/navigation/profilePage.dart';
import 'package:finplan/screens/no_internet/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  int selectedItemPosition = 2;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  List<Widget> pages = [
    NotificationPage(),
    CalendarPage(),
    HomePage(),
    PaymentPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
        if (snapshot.data != ConnectivityResult.none) {
          return Scaffold(
            bottomNavigationBar: SnakeNavigationBar.color(
              behaviour: SnakeBarBehaviour.pinned,
              snakeShape: SnakeShape.indicator,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              backgroundColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
              snakeViewColor: Theme.of(context).primaryColor,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              currentIndex: selectedItemPosition,
              //TODO Uraditi sa bloc-om setState
              onTap: (index) {
                setState(
                  () {
                    selectedItemPosition = index;
                  },
                );
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications),
                  label: 'notifications',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today),
                  label: 'calendar',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.attach_money_sharp),
                  label: 'payments',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: 'profile',
                ),
              ],
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            body: pages[selectedItemPosition],
          );
        } else {
          return NoInternetScreen();
        }
      },
    );
  }
}
