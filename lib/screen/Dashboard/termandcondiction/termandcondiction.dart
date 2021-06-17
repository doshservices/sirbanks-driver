import 'package:flutter/material.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class TermandCondition extends StatefulWidget {
  @override
  _TermandConditionState createState() => _TermandConditionState();
}

class _TermandConditionState extends State<TermandCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color(0xff24414D),
                    borderRadius: BorderRadius.circular(10)),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Terms and conditioms',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Your Agreement',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffFB5448),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d. \n\nPLEASE NOTE: Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d Amet minim mollit non deserunt ullamco est sit aliqua d',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff96969B),
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        height: 55,
                        width: double.infinity,
                        child: RoundedRaisedButton(
                          // circleborderRadius: 10,
                          title: "Accept",
                          titleColor: Colors.white,
                          buttonColor: Color(0xff24414D),
                          onPress: () {
                            // Navigator.of(context).pushNamed(kSignupScreen);
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     kDashbord, (route) => false);
                          },
                        )),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        height: 55,
                        width: double.infinity,
                        child: RoundedRaisedButton(
                          // circleborderRadius: 10,
                          title: "Cancel",
                          titleColor: Colors.white,
                          buttonColor: Color(0xffBDBDBD),
                          onPress: () {
                            // Navigator.of(context).pushNamed(kSignupScreen);
                            // Navigator.of(context).pushNamedAndRemoveUntil(
                            //     kDashbord, (route) => false);
                          },
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
