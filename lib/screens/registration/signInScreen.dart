import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_bloc.dart';
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
                TextButton(
                  onPressed: () {
                    context.setLocale(Locale('en', 'US'));
                  },
                  child: Text(
                    "English",
                  ),
                ),
                TextButton(
                    onPressed: () {
                      context.setLocale(Locale('sr', 'SR'));
                    },
                    child: Text("Serbian")),
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
          await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);
          print(_auth.currentUser?.uid);
          Navigator.of(context).pop();
          Navigator.of(context).pushNamed(IntroScreenRoute);
        } catch (e) {
          print(e.toString());
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
