import 'package:easy_localization/src/public_ext.dart';
import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:finplan/config/models/alertDialog_model.dart';
import 'package:finplan/screens/registration/widgets/signUpCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finplan/services/FirebaseApi.dart';

class SignUpPage extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  TextEditingController _confirmPwdController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();

  UserAuth _userAuth;

  SignUpPage({Key? key, required UserAuth userAuth})
      : _userAuth = userAuth,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('yes_account'.tr(), style: TextStyle(fontSize: 15, color: Colors.deepPurple)),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'log_in'.tr(),
                style: TextStyle(fontSize: 15, color: Colors.deepPurple, fontWeight: FontWeight.bold),
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
              margin: EdgeInsets.symmetric(horizontal: 15,),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text(
                    'hello'.tr(),
                    style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  UnDraw(
                    height: 150,
                    width: 150,
                    color: Colors.deepPurple,
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
                      SizedBox(width: 10,),
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
                 SizedBox(height: 20,),
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

          if(_pwdController.text == _confirmPwdController.text) {
            final data = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);

            FirebaseApi.addItem(userEmail: _emailController.text,
                dateCreated: DateTime.now(),
                userFirstName: _firstNameController.text,
                userLastName: _lastNameController.text,
                userPassword: _pwdController.text);
            showAlertFunction(context, "success".tr(),"register_success".tr());

          }
          else{
            showAlertFunction(context, "passwords_not_same".tr(), "confirm_passwords".tr());
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
          color: Colors.deepPurple.shade400,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            'sign_up'.tr(),
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
