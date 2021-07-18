import 'package:flutter/material.dart';

import '../../../constants.dart';

class CardPayment extends StatefulWidget {
  // const CardPayment({ Key? key }) : super(key: key);

  @override
  _CardPaymentState createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
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
      body: Column(children: [
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
                    'Card payment',
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
        SizedBox(height: 10),
        Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {
                    // Navigator.of(context).pushNamed(KPaymentMethod);
                  },
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Color(0xff24414D)),
                    child: Center(
                      child: Image.asset('assets/icons/wal.png'),
                    ),
                  ),
                  title: Text(
                    'Add new card',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  trailing: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Color(0xffEE6457), width: 2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3),
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffEE6457)),
                      ),
                    ),
                  ),
                )
              )
          ),
          SizedBox(
            height: 30
          ),
          Card(
            child: ListTile(
              title: Text('CREDIT CARDS'),
            ),
          )
      ]),
    );
  }
}