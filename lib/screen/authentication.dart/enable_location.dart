import 'dart:async';
import "package:flutter/material.dart";
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

import '../../constants.dart';

class EnableLocationScreen extends StatefulWidget {
  @override
  _EnableLocationScreenState createState() => _EnableLocationScreenState();
}

class _EnableLocationScreenState extends State<EnableLocationScreen> {
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Expanded(child: Container()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 60,
                          ),
                          Image.asset('assets/images/location.png'),
                          SizedBox(
                            height: 60,
                          ),
                          Text(
                            'Enable your location',
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            'Choose your location to start. Find request around you.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff696969),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 55,
                    width: double.infinity,
                    child: RoundedRaisedButton(
                      // circleborderRadius: 10,
                      title: "Use my location",
                      titleColor: Colors.white,
                      buttonColor: Color(0xff24414D),
                      onPress: () {
                        Navigator.of(context).pushNamed(kSignupScreen);
                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     kDashbord, (route) => false);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).pushNamed(kSignupScreen);
                          },
                          child: Text(
                            'Skip for now',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffFB5448)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
