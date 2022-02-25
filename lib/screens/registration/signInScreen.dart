import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:finplan/config/models/alertDialog_model.dart';
import 'package:finplan/screens/registration/widgets/signInCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:finplan/values/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_localization/easy_localization.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  final UserAuth _userAuth;

  SignInPage({Key? key, required UserAuth userAuth})
      : _userAuth = userAuth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'no_account'.tr(),
              style: TextStyle(
                fontSize: 15,
                //color: Theme.of(context).primaryColor,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SignUpPageRoute);
              },
              child: Text(
                'sign_up'.tr(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  //color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider<SignInBloc>(
        create: (context) => SignInBloc(userAuth: _userAuth),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'FinPlan',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                UnDraw(
                  height: 150,
                  width: 150,
                  color: Theme.of(context).primaryColor,
                  illustration: UnDrawIllustration.online_banking,
                  placeholder: CircularProgressIndicator(),
                  errorWidget: Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                ),
                SizedBox(height: 25),
                SignInCard(
                  userAuth: _userAuth,
                  size: MediaQuery.of(context).size.width - 60,
                  icon: Icons.email,
                  title: 'e_mail'.tr(),
                  controller: _emailController,
                  hidden: false,
                ),
                SizedBox(height: 15),
                SignInCard(
                  userAuth: _userAuth,
                  size: MediaQuery.of(context).size.width - 60,
                  icon: Icons.lock,
                  title: 'password'.tr(),
                  controller: _pwdController,
                  hidden: true,
                ),
                SizedBox(height: 15),
                signInButton(context),
                SizedBox(height: 15),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("forgot-password".tr()),
                      Text(
                        "reset".tr(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  onTap: () async {
                    Navigator.pushNamed(context, PasswordResetScreenRoute);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          if (_emailController.text == "" || _pwdController.text == "") {
            showAlertFunction(
              buildContext: context,
              title: "fields-empty".tr(),
              message: "fields-empty-message".tr(),
              closingText: "close".tr(),
              affirmativeText: "try_again".tr(),
              onPressedFunction: () {
                Navigator.of(context).pop();
              },
            );
          }
          else{
            await _auth.signInWithEmailAndPassword(
                email: _emailController.text, password: _pwdController.text);
            Navigator.of(context).pop();
            Navigator.of(context).pushNamed(IntroScreenRoute);
          }

        } catch (e) {
          if (e.toString().substring(
                  e.toString().indexOf(' ') + 1, e.toString().length) ==
              "The email address is badly formatted.") {
            showAlertFunction(
              buildContext: context,
              title: "email-wrong-format".tr(),
              message: "email-format-correctly".tr(),
              closingText: "close".tr(),
              affirmativeText: "try_again".tr(),
              onPressedFunction: () {
                Navigator.of(context).pop();
              },
            );
          } else if (e.toString().substring(
                  e.toString().indexOf(' ') + 1, e.toString().length) ==
              "There is no user record corresponding to this identifier. The user may have been deleted.") {
            showAlertFunction(
              buildContext: context,
              title: "no-user".tr(),
              message: "no-user-message".tr(),
              closingText: "close".tr(),
              affirmativeText: "try_again".tr(),
              onPressedFunction: () {
                Navigator.of(context).pop();
              },
            );
          } else if (e.toString().substring(
                  e.toString().indexOf(' ') + 1, e.toString().length) ==
              "The password is invalid or the user does not have a password.") {
            showAlertFunction(
              buildContext: context,
              title: "password-bad".tr(),
              message: "password-bad-message".tr(),
              closingText: "close".tr(),
              affirmativeText: "try_again".tr(),
              onPressedFunction: () {
                Navigator.of(context).pop();
              },
            );
          }

          print(e
              .toString()
              .substring(e.toString().indexOf(' ') + 1, e.toString().length));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            'log_in'.tr(),
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
