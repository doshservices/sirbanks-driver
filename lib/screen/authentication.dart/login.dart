import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/provider/auth.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool furnish = false;
  GlobalKey<FormState> _loginFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  bool _obscurePassword = true, rememberMe = true;
  String errMsg = "";
  String _userEmail = "";
  String _userPassword = "";
  bool _isLoading = false;

  _showShackBar(errorMessage) {
    final snackBar = new SnackBar(
      content: Text(
        errorMessage.toString(),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Colors.red[400],
    );

    _scaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<void> _submitLogin() async {
    if (!_loginFormKey.currentState.validate()) {
      return;
    }
    _loginFormKey.currentState.save();
    setState(() {
      _isLoading = true;
      errMsg = "";
    });
    try {
      await Provider.of<Auth>(context, listen: false)
          .signIn(_userEmail, _userPassword);
      // await Provider.of<Auth>(context, listen: false).getUserDetail();
      setState(() {
        errMsg = "";
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(kDashboard, (route) => false);
    } catch (error) {
      if (error.toString().isNotEmpty) {
        _showShackBar(error.toString());
        setState(() {
          errMsg = error.toString();
        });
      } else {
        _showShackBar('Invalid credential');
        setState(() {
          errMsg = "Invalid credential";
        });
      }
    } finally {
      setState(() {
        // errMsg = "";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
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
                    key: _loginFormKey,
                    child: Column(
                      children: [
                        TextFormField(
                          style: TextStyle(
                              color: Colors.black,
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
                              return "Required";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userEmail = value;
                          },
                        ),
                        SizedBox(height: 30),
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
                              return "Required";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _userPassword = value;
                          },
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: FlatButton(
                      onPressed: () {
                        // Navigator.of(context).pushNamed(KForgotPassword);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(fontSize: 16),
                      ),
                      textColor: Color(0xff24414D),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              errMsg.toString() != ""
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "$errMsg",
                        style: TextStyle(color: Colors.red[300]),
                      ),
                    )
                  : Text(""),
              SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 55,
                  width: double.infinity,
                  child: RoundedRaisedButton(
                    // circleborderRadius: 10,
                    title: "Login",
                    isLoading: _isLoading,
                    titleColor: Colors.white,
                    buttonColor: Color(0xff24414D),
                    onPress: () {
                      _submitLogin();
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     kDashboard, (route) => false);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have a Go account? ",
                          style: TextStyle(color: Color(0xff292C31))),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(kSignupScreen);
                        },
                        child: Text("Create one",
                            style: TextStyle(color: Color(0xffFB5448))),
                      )
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Row(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       GestureDetector(
              //         onTap: () {
              //           // Navigator.of(context).pushNamed(kLoginScreen);
              //         },
              //         child: Text(
              //           'Forgot password? ',
              //           style: TextStyle(
              //               fontSize: 14,
              //               color: Color(0xffFB5448),
              //               fontWeight: FontWeight.bold),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
