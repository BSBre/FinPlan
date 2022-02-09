import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


  void showAlertFunction(BuildContext context,String title,String message) {


    Widget closingButton = TextButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.deepPurple.shade400)
          ),
        ),
      ),
      child: Text("Close",style: TextStyle(fontSize: 15, color: Colors.white),),
    );

    Widget allowButton = TextButton(
      onPressed: () {
        AwesomeNotifications().requestPermissionToSendNotifications().then((_) => Navigator.pop(context));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple.shade400),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.deepPurple.shade400)
          ),
        ),
      ),
      child: Text("Allow",style: TextStyle(fontSize: 15, color: Colors.white),),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          title: Text(title),
          content: Text(message),
          actions: <Widget>[closingButton, allowButton],
        );
      },
    );
  }

