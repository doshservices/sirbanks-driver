import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
                    'Notifications',
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
            height: 15,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff24414D),
                    radius: 30,
                    child: Center(child: Image.asset('assets/icons/mark.png')),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bello Sam',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Booking #34554 is successful',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff24414D),
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xffFB5448),
                    radius: 30,
                    child: Center(child: Icon(Icons.close, color: Colors.white,)),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bello Sam',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Booking #34554 is successful',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff24414D),
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xff49A529),
                    radius: 30,
                    child: Center(child: Image.asset('assets/icons/gift.png')),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bello Sam',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Booking #34554 is successful',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff24414D),
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
