import 'package:easy_localization/src/public_ext.dart';
import 'package:finplan/values/constants.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    slides.add(
      new Slide(
        title: "intro_title1".tr(),
        maxLineTitle: 1,
        styleTitle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: TextColor,
        ),
        description: "intro_description1".tr(),
        styleDescription: TextStyle(
          fontSize: 20.0,
          color: TextColor,
        ),
        backgroundImage: "assets/images/intro1.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "intro_title2".tr(),
        styleTitle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: TextColor,
        ),
        description: "intro_description2".tr(),
        styleDescription: TextStyle(
          fontSize: 20.0,
          color: TextColor,
        ),
        backgroundImage: "assets/images/intro2.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "intro_title3".tr(),
        styleTitle: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: TextColor,
        ),
        description: "intro_description3".tr(),
        styleDescription: TextStyle(
          fontSize: 20.0,
          color: TextColor,
        ),
        backgroundImage: "assets/images/intro3.jpg",
      ),
    );
  }

  void onDonePress() {
    Navigator.pop(context);
    Navigator.pushNamed(context, HomePageRoute);
  }

  void onNextPress() {
    print("onNextPress caught");
  }

  Widget renderNextBtn() {
    return Text(
      "next".tr(),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "done".tr(),

    );
  }

  Widget renderSkipBtn() {
    return Text(
      "skip".tr(),

    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(
        Theme.of(context).primaryColor,
      ),
      overlayColor: MaterialStateProperty.all<Color>(
        Theme.of(context).secondaryHeaderColor,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(Theme.of(context).secondaryHeaderColor),

    );
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // List slides
      slides: this.slides,

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: this.renderNextBtn(),
      onNextPress: this.onNextPress,
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Theme.of(context).primaryColor,
      colorActiveDot: Theme.of(context).secondaryHeaderColor,
      sizeDot: 10.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Theme.of(context).secondaryHeaderColor,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
