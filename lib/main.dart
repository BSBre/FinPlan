import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:finplan/bloc/authentication_bloc/authentication_state.dart';
import 'package:finplan/bloc/bloc_observer.dart';
import 'package:finplan/config/navigation/app_router.dart';
import 'package:finplan/screens/home/homeScreen.dart';
import 'package:finplan/screens/navigation/calendarPage.dart';
import 'package:finplan/screens/navigation/profilePage.dart';
import 'package:finplan/screens/no_internet/no_internet_screen.dart';
import 'package:finplan/screens/registration/signInScreen.dart';
import 'package:finplan/utilities/theme_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:finplan/values/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

// BLOC LOG IN VIDEO
//
//
// https://www.youtube.com/watch?v=xGqMgHnDgb8 25:00
//
//
// BLOC LOG IN VIDEO

void main() async {
  AwesomeNotifications().initialize(
    "resource://drawable/res_notification_icon",
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notifications you receive whenever',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled notifications',
        channelDescription: 'Notifications you schedule when to appear',
        importance: NotificationImportance.High,
        channelShowBadge: true,
      )
    ],
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  final UserAuth userAuth = UserAuth(firebaseAuth: FirebaseAuth.instance);
  FirebaseMessaging.onBackgroundMessage(_fireBaseMessagingNotification);
  BlocOverrides.runZoned(
    () => runApp(
      BlocProvider(
        child: EasyLocalization(

          startLocale: Locale('sr', 'SR'),
          path: 'assets/translations',
          supportedLocales: [
            Locale('en', 'US'),
            Locale('sr', 'SR'),
          ],
          saveLocale: true,
          fallbackLocale: Locale('en', 'US'),
          child: MyApp(
            userAuth: userAuth,
          ),
        ),
        create: (context) => AuthenticationBloc(userAuth: userAuth),
      ),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatefulWidget {
  final UserAuth _userAuth;

  MyApp({required UserAuth userAuth}) : _userAuth = userAuth;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeProvider>(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            debugShowCheckedModeBanner: false,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            locale: context.locale,
            home: StreamBuilder(
              stream: Connectivity().onConnectivityChanged,
              builder: (BuildContext context, AsyncSnapshot<ConnectivityResult> snapshot) {
                if (snapshot.data != ConnectivityResult.none) {
                  return BlocBuilder<AuthenticationBloc, AuthenticationState>(
                    builder: (context, state) {
                      if (state is AuthenticationFailure) {
                        return SignInPage(userAuth: widget._userAuth);

                      } else if (state is AuthenticationSuccess) {
                        return HomeScreen();
                      } else {
                        return SignInPage(userAuth: widget._userAuth);
                      }
                    },
                  );
                } else {
                  return NoInternetScreen();
                }
              },
            ),
            onGenerateRoute: AppRouter(userAuth: widget._userAuth).onGenerateRoute,
            initialRoute: SignInPageRoute,
          );
        });
  }
}

Future<void> _fireBaseMessagingNotification(RemoteMessage message) async {
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}
