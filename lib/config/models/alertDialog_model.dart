import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlertFunction({
  required BuildContext buildContext,
  required String title,
  required String message,
  required String closingText,
  required String affirmativeText,
  required Function onPressedFunction,
}) {
  showDialog(
    context: buildContext,
    builder: (BuildContext buildContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(buildContext).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.deepPurple.shade400)),
              ),
            ),
            child: Text(
              closingText,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () => onPressedFunction(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.deepPurple.shade400)),
              ),
            ),
            child: Text(
              affirmativeText,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
