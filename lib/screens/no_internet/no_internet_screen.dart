import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "no_internet".tr(),
                  style: TextStyle(fontSize: 25),
                ),
                Image.asset("assets/images/wi-fi.gif"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "check_internet".tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 19),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
