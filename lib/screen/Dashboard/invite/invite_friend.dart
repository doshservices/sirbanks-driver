import 'package:flutter/material.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class InviteFriendScreen extends StatefulWidget {
  @override
  _InviteFriendScreenState createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            // _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      'Language',
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
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                  color: Color(0xff444444), shape: BoxShape.circle),
              child: Image.asset('assets/images/person_2.png'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Text(
                'Invite Friends',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xffFB5448),
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Earn up to ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff24414D),
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'N1,000 ',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff24414D),
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'per',
                    style: TextStyle(
                        fontSize: 24,
                        color: Color(0xff24414D),
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Text(
                'referral',
                style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff24414D),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'When your friends sign up using your \nreferral, you get  N1,000 per refferal',
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff24414D),
                fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'SHARE YOUR INVITE CODE',
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xffBDBDBD),
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.all(20),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Color(0xffE5E5E5),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                    child: Text(
                  '4455644',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff24414D),
                    fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                )),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.all(20),
            height: 55,
            width: double.infinity,
            child: RoundedRaisedButton(
              // circleborderRadius: 10,
              title: "Invite",
              titleColor: Colors.white,
              buttonColor: Color(0xff24414D),
              onPress: () {
                // Navigator.of(context).pushNamed(kSignupScreen);
                // Navigator.of(context).pushNamedAndRemoveUntil(
                //     kDashbord, (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
