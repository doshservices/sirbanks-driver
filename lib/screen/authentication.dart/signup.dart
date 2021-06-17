import 'package:flutter/material.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                              color: Color(0xff178B14),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                          decoration: InputDecoration(
                            focusColor: Colors.black,
                            hintText: "name@example.com",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xffC3BBBB),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your firstname";
                            }
                          },
                          onSaved: (value) {
                            // _regData["firstName"] = value;
                          },
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 55,
                          width: double.infinity,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image.asset('assets/icons/flag.png'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                  Text('+234'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextFormField(
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
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Please enter your firstname";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        // _regData["firstName"] = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xffC3BBBB),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your firstname";
                            }
                          },
                          onSaved: (value) {
                            // _regData["firstName"] = value;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(
                              color: Color(0xff178B14),
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal),
                          decoration: InputDecoration(
                            hintText: "Re-enter password",
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Color(0xffC3BBBB),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter your firstname";
                            }
                          },
                          onSaved: (value) {
                            // _regData["firstName"] = value;
                          },
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
                    // circleborderRadius: 10,
                    title: "Sign up",
                    titleColor: Colors.white,
                    buttonColor: Color(0xff24414D),
                    onPress: () {
                      Navigator.of(context).pushNamed(kLoginScreen);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     kDashbord, (route) => false);
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
                      Navigator.of(context).pushNamed(kLoginScreen);
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
