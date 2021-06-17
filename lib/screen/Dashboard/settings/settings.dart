import 'package:flutter/material.dart';
import 'package:sirbanks_driver/constants.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        elevation: 1,
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
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: Color(0xff24414D),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Settings',
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
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(KProfileScreen);
                },
                leading: Container(
                    height: 70,
                    width: 70,
                    child: Image.asset(
                      'assets/images/person_3.png',
                      height: 100,
                      fit: BoxFit.fill,
                    )),
                title: Text(
                  'Balogun Rasheed',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  '',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(KReviewScreen);
                },
                leading: Container(
                    child: Image.asset(
                  'assets/icons/star.png',
                )),
                title: Text(
                  'Reviews',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(KLanguageScreen);
                },
                leading: Container(
                    child: Image.asset(
                  'assets/icons/Vectorworld.png',
                )),
                title: Text(
                  'Language',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(KNotificationScreen);
                },
                leading: Container(
                    child: Image.asset(
                  'assets/icons/notification.png',
                )),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(KTermandCondition);
                },
                leading: Container(
                    child: Image.asset(
                  'assets/icons/Vectorking.png',
                )),
                title: Text(
                  'Terms and Privacy policy',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(KContactUs);
                },
                leading: Container(
                    child: Image.asset(
                  'assets/icons/Vectorwhy.png',
                )),
                title: Text(
                  'Contact us',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
              ),
            ),
          )
        ],
      ),
    );
  }
}
