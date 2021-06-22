import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/provider/auth.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class OtpScreen extends StatefulWidget {
  // const OtpScreen({ Key? key }) : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var onTapRecognizer;
  TextEditingController newTextEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String otpcode;

  bool _isLoading = false;
  bool _isResending = false;

  Future<void> verifyOtp(
      BuildContext context, String number, String token) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).verifyOtp(number, token);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Success",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content:
                  Text("Your phone number has been successfully verified."),
              actions: [
                FlatButton(
                  child: Text("Proceed to Login",
                      style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Error",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("$error"),
              actions: [
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.white)),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        appBar: AppBar(
          backgroundColor: Color(0xffF2F2F2),
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                  color: Color(0xff24414D),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone verification',
                      style: TextStyle(
                          fontSize: 26,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Enter your ',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            Text(
                              'OTP ',
                              style: TextStyle(
                                  fontSize: 24, color: Color(0xffFB5448)),
                            ),
                            Text(
                              'here',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: PinCodeFields(
                  keyboardType: TextInputType.number,
                  length: 4,
                  controller: newTextEditingController,
                  focusNode: focusNode,
                  animationDuration: const Duration(milliseconds: 200),
                  animationCurve: Curves.easeInOut,
                  switchInAnimationCurve: Curves.easeIn,
                  switchOutAnimationCurve: Curves.easeOut,
                  onComplete: (result) {
                    otpcode = result;
                    print(result);
                  },
                  onChange: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  }
                )),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                margin: EdgeInsets.all(10),
                height: 55,
                width: double.infinity,
                child: RoundedRaisedButton(
                  isLoading: _isLoading,
                  title: "Verify now",
                  titleColor: Colors.white,
                  buttonColor: Color(0xff24414D),
                  onPress: () async {
                    if (newTextEditingController.text.length < 4) {
                    } else {
                      await verifyOtp(context, arguments["phone"],
                          newTextEditingController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            // GestureDetector(
            //   onTap: () {},
            //   child: Text(
            //     'Resend code',
            //     style: TextStyle(fontSize: 18, color: Color(0xffFB5448)),
            //   ),
            // ),
          ]),
        ));
  }
}
