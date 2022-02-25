import 'package:easy_localization/src/public_ext.dart';
import 'package:finplan/config/models/alertDialog_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class PasswordResetScreen extends StatelessWidget {
  final emailController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 60,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).secondaryHeaderColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                child: TextFormField(
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  cursorColor: Theme.of(context).primaryColor,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.email,
                      size: 20,
                    ),
                    hintText: 'e_mail'.tr(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () async {
                try {
                  await _auth.sendPasswordResetEmail(email: emailController.text);
                  showAlertFunction(
                    buildContext: context,
                    onPressedFunction: () {
                      Navigator.of(context).pop();
                    },
                    affirmativeText: "Log-in",
                    closingText: "close",
                    title: "Success",
                    message: "Email for password reset has been sent",
                  );
                } catch (e) {
                  print(e.toString());
                  showAlertFunction(
                    buildContext: context,
                    onPressedFunction: () {
                      Navigator.of(context).pop();
                    },
                    affirmativeText: "ok",
                    closingText: "close",
                    title: "Error",
                    message: e.toString().substring(e.toString().indexOf(' ')+1, e.toString().length),
                  );
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
                    "Reset password",
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
