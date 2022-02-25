import 'package:easy_localization/src/public_ext.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:finplan/config/models/alertDialog_model.dart';
import 'package:finplan/screens/registration/widgets/signUpCard.dart';
import 'package:finplan/values/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finplan/services/FirebaseApi.dart';

class SignUpPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();
  final TextEditingController _confirmPwdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  final UserAuth _userAuth;

  SignUpPage({Key? key, required UserAuth userAuth})
      : _userAuth = userAuth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'yes_account'.tr(),
              style: TextStyle(
                fontSize: 15,
                //color: Theme.of(context).primaryColor,
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'log_in'.tr(),
                style: TextStyle(
                  fontSize: 15,
                  //color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: BlocProvider<SignUpBloc>(
        create: (context) => SignUpBloc(userAuth: _userAuth),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 40,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'hello'.tr(),
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
                    errorWidget: Icon(Icons.error_outline, color: Colors.red, size: 50),
                  ),
                  SizedBox(height: 10),
                  SignUpCard(
                    containerWidth: double.infinity,
                    userAuth: _userAuth,
                    icon: Icons.email,
                    title: 'e_mail'.tr(),
                    controller: _emailController,
                    hidden: false,
                  ),
                  SignUpCard(
                    containerWidth: double.infinity,
                    userAuth: _userAuth,
                    icon: Icons.lock,
                    title: 'password'.tr(),
                    controller: _pwdController,
                    hidden: true,
                  ),
                  SignUpCard(
                    containerWidth: double.infinity,
                    userAuth: _userAuth,
                    icon: Icons.lock,
                    title: 'repeat_password'.tr(),
                    controller: _confirmPwdController,
                    hidden: true,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SignUpCard(
                          containerWidth: double.infinity,
                          userAuth: _userAuth,
                          icon: Icons.account_circle,
                          title: 'first_name'.tr(),
                          controller: _firstNameController,
                          hidden: false,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SignUpCard(
                          containerWidth: double.infinity,
                          userAuth: _userAuth,
                          icon: Icons.account_circle,
                          title: 'last_name'.tr(),
                          controller: _lastNameController,
                          hidden: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  signUpButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          if (_pwdController.text == _confirmPwdController.text) {
            final data = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);

            FirebaseApi.addItem(
                userEmail: _emailController.text,
                userId: data.user?.uid,
                dateCreated: DateTime.now(),
                userFirstName: _firstNameController.text,
                userLastName: _lastNameController.text,
                userPassword: _pwdController.text);

            showAlertFunction(
              buildContext: context,
              title: "success".tr(),
              message: "register_success".tr(),
              closingText: "close".tr(),
              affirmativeText: "log_in".tr(),
              onPressedFunction: () {
                Navigator.popUntil(context, ModalRoute.withName(SignInPageRoute));
              },
            );
          } else {
            showAlertFunction(
              buildContext: context,
              title: "passwords_not_same".tr(),
              message: "confirm_passwords".tr(),
              closingText: "close".tr(),
              affirmativeText: "try_again".tr(),
              onPressedFunction: () {
                Navigator.pop(context);
              },
            );
            // passwordsDifferentAlert(context);
          }
        } catch (e) {
          print(e.toString());
        }
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            'sign_up'.tr(),
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
        ),
      ),
    );
  }
}
