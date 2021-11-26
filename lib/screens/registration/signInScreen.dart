import 'package:finplan/screens/home/homeScreen.dart';
import 'package:finplan/screens/registration/signUpScreen.dart';
import 'package:finplan/screens/registration/widgets/signCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class SignInPage extends StatelessWidget {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Don\'t have account? ', style: TextStyle(fontSize: 15, color: Colors.deepPurple)),
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/SignUpPage');
              },
              child: Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back',
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
              SizedBox(height: 25),
              SignCard(
                size: MediaQuery.of(context).size.width - 60,
                icon: Icons.email,
                title: 'E-mail',
                controller: _emailController,
                hidden: false,
              ),
              SizedBox(height: 15),
              SignCard(
                size: MediaQuery.of(context).size.width - 60,
                icon: Icons.lock,
                title: 'Password',
                controller: _pwdController,
                hidden: true,
              ),
              SizedBox(height: 15),
              signInButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          firebase_auth.UserCredential userCredential =
              await firebaseAuth.signInWithEmailAndPassword(email: _emailController.text, password: _pwdController.text);
          Navigator.of(context).pushNamed("/homePage");
        } catch (e) {
          print(e.toString());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade400,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            'LOGIN',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
