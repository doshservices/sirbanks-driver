import 'package:flutter/material.dart';

import '../../../constants.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<bool> isSelected;
  bool availableStatus;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
  }

  @override
  void dispose() {
    super.dispose();
  }

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              height: 230,
              child: Column(
                children: [
                  Container(
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
                          'My wallet',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        ToggleButtons(
                          borderColor: Colors.grey,
                          fillColor: Color(0xffFB5448),
                          borderWidth: 1,
                          selectedBorderColor: Colors.black,
                          selectedColor: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Cash',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Discount',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                          onPressed: (int index) {
                            setState(() {
                              for (int i = 0; i < isSelected.length; i++) {
                                isSelected[i] = i == index;
                              }
                              if (index == 0) {
                                availableStatus = false;
                              } else {
                                availableStatus = true;
                              }
                            });
                          },
                          isSelected: isSelected,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'N0.00',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Total Earned',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xffBDBDBD),
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //     horizontal: 10,
          //   ),
          //   child: Card(
          //       child: ListTile(
          //           onTap: () {
          //             Navigator.of(context).pushNamed(KPaymentMethod);
          //           },
          //           title: Text(
          //             'Payment method',
          //             style: TextStyle(
          //                 fontSize: 18,
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.w700),
          //           ),
          //           trailing: Icon(Icons.keyboard_arrow_right))),
          // ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
            ),
            child: Text(
              'PAYMENT HISTORY',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xffBDBDBD),
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: ListView.builder(
                  itemCount: 0,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          child: Row(
                            children: [
                              Image.asset('assets/images/imagepr.png'),
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
                                    'Oke-ira to College road',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xffFB5448),
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffFB5448),
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.end,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'N3,000',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffFB5448),
                                          fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
