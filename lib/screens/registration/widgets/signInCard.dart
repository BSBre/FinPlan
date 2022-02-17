import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:finplan/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:finplan/values/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInCard extends StatefulWidget {
  final double size;
  final IconData icon;
  final String title;
  final TextEditingController controller;
  final bool hidden;

  SignInCard({required this.size, required this.icon, required this.title, required this.controller, required this.hidden, required this.userAuth});

  final UserAuth userAuth;

  @override
  State<SignInCard> createState() => _SignInCardState();
}

class _SignInCardState extends State<SignInCard> {
  //PROVERITI DA LI TREBA LATE ILI KONSTRUKTOR
  late SignInBloc _signInBloc;

  @override
  void initState() {
    super.initState();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state.isFailure) {}
        if (state.isSubmitting) {
          // ScaffoldMessenger.of(context).removeCurrentSnackBar();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Row(
          //       children: <Widget>[Text("Logging in"), CircularProgressIndicator()],
          //     ),
          //   ),
          // );
        }
        if (state.isSuccess) {}
      },
      child: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return Container(

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
                controller: widget.controller,
                obscureText: widget.hidden,
                decoration: InputDecoration(
                  icon: Icon(
                    widget.icon,
                    size: 20,
                  ),
                  hintText: widget.title,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
