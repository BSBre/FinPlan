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
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "intro_description1".tr(),
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        backgroundImage: "assets/images/intro1.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "intro_title2".tr(),
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "intro_description2".tr(),
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        backgroundImage: "assets/images/intro2.jpg",
      ),
    );
    slides.add(
      new Slide(
        title: "intro_title3".tr(),
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "intro_description3".tr(),
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
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
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "done".tr(),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      "skip".tr(),
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(FinPlanColor),
      overlayColor: MaterialStateProperty.all<Color>(FinPlanColor),
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
      colorDot: FinPlanColor,
      colorActiveDot: Colors.white,
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,

      // Scrollbar
      verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
    );
  }
}
