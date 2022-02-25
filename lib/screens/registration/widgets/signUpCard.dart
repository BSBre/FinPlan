import 'package:finplan/authentication/user_auth.dart';
import 'package:finplan/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:finplan/bloc/sign_up_bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpCard extends StatefulWidget {

  final IconData icon;
  final String title;
  final TextEditingController controller;
  final bool hidden;
  final double containerWidth;

  SignUpCard({required this.containerWidth,required this.icon, required this.title, required this.controller, required this.hidden, required this.userAuth});

  final UserAuth userAuth;

  @override
  State<SignUpCard> createState() => _SignUpCardState();
}

class _SignUpCardState extends State<SignUpCard> {
  //PROVERITI DA LI TREBA LATE ILI KONSTRUKTOR
  //late SignUpBloc _signUpBloc;

  @override
  void initState() {
    super.initState();
    //_signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
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
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 7.5),
            width: MediaQuery.of(context).size.width,
            child: Container(
              width: widget.containerWidth,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.circular(25),
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
                    
                      icon: FaIcon(
                        widget.icon,
                        size: 20,
                      ),
                      border: InputBorder.none,
                      hintText: widget.title,
                      hintStyle: TextStyle(fontSize: 15,color: Theme.of(context).primaryColor,),),
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
