import 'package:flutter/material.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                            'Login ',
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
                            hintText: "Email or Phone number",
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
                        SizedBox(height: 30),
                        TextFormField(
                          style: TextStyle(
                              color: Color(0xff178B14),
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
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 55,
                  width: double.infinity,
                  child: RoundedRaisedButton(
                    // circleborderRadius: 10,
                    title: "Login",
                    titleColor: Colors.white,
                    buttonColor: Color(0xff24414D),
                    onPress: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          kDashboard, (route) => false);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(kLoginScreen);
                      },
                      child: Text(
                        'Forgot password? ',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffFB5448),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}