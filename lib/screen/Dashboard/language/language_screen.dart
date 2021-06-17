import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
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
      body: Column(
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
          SizedBox(
            height: 10,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Image.asset('assets/icons/Vectorworld.png'),
                  backgroundColor: Color(0xff24414D),
                ),
                title: Text(
                  'Select your preferred',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff24414D),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                subtitle: Text(
                  'language',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff24414D),
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                // trailing: Icon(Icons.keyboard_arrow_right),
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
                leading: CircleAvatar(
                  radius: 30,
                  child: Image.asset('assets/icons/Vectorworld.png'),
                  backgroundColor: Color(0xff24414D),
                ),
                title: Text(
                  'English',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
                ),
                trailing: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Color(0xffEE6457)),
                      shape: BoxShape.circle),
                  child: Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: Color(0xffEE6457)),
                        shape: BoxShape.circle,
                        color: Color(0xffEE6457)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
