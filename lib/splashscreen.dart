import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sirbanks_driver/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   startTimer();
  // }

  // startTimer() async {
  //   var duration = Duration(seconds: 4);
  //   return Timer(duration, route);
  // }

  // route() {
  //   Navigator.of(context).popAndPushNamed(kWalkthrough);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icons/logo.jpg"),
            Text(
              'Driver App',
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff24414D),
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
