import 'package:easy_localization/src/public_ext.dart';
import 'package:finplan/utilities/theme_data.dart';
import 'package:finplan/values/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDark = false;

  final user = FirebaseAuth.instance;
  @override
  void initState() {
    if (ThemeMode.dark == true) {
      isDark = true;
    } else{
      isDark = false;
    }
    super.initState();
  }

  String dropDownValue = "language_picker".tr();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "profile".tr(),
          style: TextStyle(
            color: TextColor,
            fontSize: 30,
          ),
        ),
        actions: [
          DropdownButton<String>(
            value: dropDownValue,
            icon: const Icon(
              Icons.arrow_drop_down_outlined,
              color: Colors.white,
            ),
            dropdownColor: Theme.of(context).secondaryHeaderColor,
            elevation: 0,
            style: const TextStyle(color: TextColor,fontSize: 20),
            underline: Container(
              height: 0,
            ),
            iconSize: 28,
            onChanged: (String? newValue) {
              setState(() {
                dropDownValue = newValue!;
                if (dropDownValue == "RS") {
                  context.setLocale(Locale('sr', 'SR'));
                } else {
                  context.setLocale(Locale('en', 'US'));
                }
              });
            },
            items: <String>[
              'EN',
              'RS',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
        leadingWidth: 100.0,
        leading: ElevatedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
            elevation: MaterialStateProperty.all<double>(0.0),
            backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor),
          ),
          onPressed: () {
            setState(() {
              isDark = !isDark;
              (isDark == false) ? themeProvider.toggleTheme(false) : themeProvider.toggleTheme(true);
            });
          },
          child: Icon((isDark == false) ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://i.imgur.com/QEWmH6u.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  child: Container(
                    alignment: Alignment(0.0, 2.5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://i.imgur.com/sohWhy9.png",
                      ),
                      radius: 60.0,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Container(
                child: Text(
                  "",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
