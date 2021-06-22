import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/provider/auth.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';
import 'package:sirbanks_driver/model/user.dart';
import 'package:device_info_plus/device_info_plus.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _termsAndCondition = false;
  GlobalKey<FormState> _regFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _regscaffoldkey = GlobalKey();
  String _selectedCountryType = "", phone;
  String deviceModel, deviceName, deviceUUID;
  bool _isLoading = false;
  bool _hidePassword = true, _hideConfirmPassword = true;
  TextEditingController _passwordController = TextEditingController();
  User user = User();

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      duration: Duration(seconds: 3),
      content: Text(
        errorMessage.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: kAccentColor,
    );

    _regscaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<void> signup(BuildContext context) async {
    if (!_regFormKey.currentState.validate()) {
      return;
    }
    // if (_selectedCountryType == "") {
    //   _showShackBar("Select Country Code");
    //   return;
    // }
    // if (_termsAndCondition == false) {
    //   _showShackBar("Accept Terms and Condition");
    //   return;
    // }
    _regFormKey.currentState.save();

    setState(() {
      _isLoading = true;
    });
    // print(user.name + "/ " + user.email + "/ " + user.phone);
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        print('Running on ${androidInfo.brand}');
        setState(() {
          deviceName = "ANDROID";
          deviceModel = androidInfo.model;
          deviceUUID = androidInfo.id;
        });
      }
      if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine}');
        setState(() {
          deviceName = "IOS";
          deviceModel = iosInfo.model;
          deviceUUID = iosInfo.systemVersion;
        });
      }
      print(deviceName);
      await Provider.of<Auth>(context, listen: false)
          .signUp(user, deviceName, deviceUUID);
       setState(() {
         _isLoading = false;
       });
       Navigator.of(context).pushReplacementNamed(KOtpScreen, arguments: {'phone': user.phone});
      // showDialog(
      //     context: context,
      //     barrierDismissible: false,
      //     builder: (ctx) {
      //       return AlertDialog(
      //         title: Text(
      //           "Success",
      //           style: TextStyle(fontWeight: FontWeight.bold),
      //         ),
      //         content: Text(
      //             "Your account has been successfully created. Kindly check your email to verify Account"),
      //         actions: [
      //           FlatButton(
      //             child: Text("Proceed to Login",
      //                 style: TextStyle(color: Colors.white)),
      //             color: Theme.of(context).primaryColor,
      //             onPressed: () {
      //               Navigator.of(context).pop();
      //               Navigator.of(context).pushReplacementNamed(kLoginScreen);
      //             },
      //           ),
      //         ],
      //       );
      //     });
    } catch (error) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text(
                "Error",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text("${error.toString()}"),
              actions: [
                FlatButton(
                  child: Text("OK", style: TextStyle(color: Colors.white)),
                  color: Color(0xff24414D),
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
    return Scaffold(
      key: _regscaffoldkey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
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
                      Row(
                        children: [
                          Text(
                            'Sign up ',
                            style: TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'with email and ',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'phone number ',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Theme(
                  data: ThemeData(
                    primaryColor: Colors.black,
                    focusColor: Colors.black,
                    // colorScheme:
                    //     ColorScheme.fromSwatch(primarySwatch: Colors.black),
                  ),
                  child: Form(
                    key: _regFormKey,
                    child: Column(
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.black,
                                hintText: "name@example.com",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffC3BBBB),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Email required";
                                } else if (!value.contains("@") ||
                                    !value.contains(".")) {
                                  return "Enter a valid email address";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (value) {
                                user.email = value;
                              },
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            TextFormField(
                              // keyboardAppearance: Brightness.light,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.black,
                                hintText: "+2348123223423",
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffC3BBBB),
                                  fontWeight: FontWeight.w400,
                                ),
                                contentPadding: EdgeInsets.zero,
                                // prefix: Row(
                                //   children: [
                                //     SizedBox(
                                //       width: 5,
                                //     ),
                                //     Image.asset(
                                //         'assets/icons/flag.png'),
                                //     SizedBox(
                                //       width: 5,
                                //     ),
                                //     Icon(Icons.arrow_drop_down),
                                //     Text('+234', style: TextStyle(color: Colors.black)),
                                //     SizedBox(
                                //       width: 5,
                                //     ),
                                //   ],
                                // ),
                                
                              ),
                              validator: (value) {
                                String pattern = r'(?=.*?[+])(?=.*?[0-9]).{14,}$';
                                RegExp regExp = new RegExp(pattern);
                                if (value.length == 0) {
                                  return 'Please enter mobile number';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid mobile number';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                user.phone = value.toString();
                              },
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  focusColor: Colors.black,
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xffC3BBBB),
                                    fontWeight: FontWeight.w400,
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _hidePassword = !_hidePassword;
                                      });
                                    },
                                    icon: _hidePassword
                                        ? Icon(Icons.visibility_off,
                                            color: Colors.grey)
                                        : Icon(
                                            Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                  )),
                              validator: (value) {
                                String pattern = r'^(?=.*?[a-z])';
                                String pattern2 = r'^(?=.*?[0-9])';
                                RegExp regExp = new RegExp(pattern);
                                RegExp regExp2 = new RegExp(pattern2);
                                if (value.isEmpty) {
                                  return "Password can't be empty";
                                }
                                if (value.length < 7) {
                                  return "Password must be between 7 to 30 characters";
                                }
                                if (regExp.hasMatch(value).toString() !=
                                    "true") {
                                  print(regExp.hasMatch(value));
                                  return "Password must have at least one lowercase character !!";
                                }
                                if (regExp2.hasMatch(value).toString() !=
                                    "true") {
                                  print(regExp.hasMatch(value));
                                  return "Password must have at least one digit character !!";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                user.password = value;
                              },
                              obscureText: _hidePassword,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          children: [
                            TextFormField(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusColor: Colors.black,
                                hintText: "Re-enter password",
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _hideConfirmPassword =
                                          !_hideConfirmPassword;
                                    });
                                  },
                                  icon: _hideConfirmPassword
                                      ? Icon(Icons.visibility_off,
                                          color: Colors.grey)
                                      : Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                ),
                                hintStyle: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xffC3BBBB),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              validator: (value) {
                                if (value != _passwordController.text) {
                                  return "Password does not match";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                // _regData["firstName"] = value;
                              },
                              obscureText: _hideConfirmPassword,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: Colors.black,
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 55,
                  width: double.infinity,
                  child: RoundedRaisedButton(
                    isLoading: _isLoading,
                    title: "Sign up",
                    titleColor: Colors.white,
                    buttonColor: Color(0xff24414D),
                    onPress: () {
                      // Navigator.of(context).pushReplacementNamed(KOtpScreen, arguments: {'phone': user.phone});
                      signup(context);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffFB5448),
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xffFB5448),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
