import 'package:flutter/material.dart';
import 'package:quizzesfun/editprofile.dart';
import 'package:quizzesfun/main.dart';

import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 15,
      navigateAfterSeconds: new MyHomePage(),
      backgroundColor: Colors.black,
      image: Image.asset("assets/otak1.gif"),
      loaderColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      loadingText: Text(
        "Loading...",
        style: TextStyle(color: Colors.white),
      ),
      photoSize: 180.0,
    );
  }
}
