import 'package:flutter/material.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class SelectRideWidgt extends StatefulWidget {
  Map data;
  // Map value;
  SelectRideWidgt({this.data,
  //  this.value, 
   Key key}) : super(key: key);

  @override
  _SelectRideWidgtState createState() => _SelectRideWidgtState();
}

class _SelectRideWidgtState extends State<SelectRideWidgt> {
  // print(widget.data.);
  @override
  Widget build(BuildContext context) {
    print(widget.data.toString());
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      height: 250,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                    color: Color(0xffF2F2F2),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Pick up',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xffBDBDBD),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 10),
                            Text(
                              widget.data['dropOff'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.s,
                          children: [
                            Text(
                              'Destination',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xffBDBDBD),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.data['pickUp'].toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${widget.data['durationToRider'].toString()} /${widget.data['distanceToRider'].toString()}',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                            Text(
                              ' ',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w600),
                              // textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        SizedBox(height: 10)
                      ],
                    )),
              Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              height: 55,
              width: double.infinity,
              child: RoundedRaisedButton(
                title: "Start ride",
                titleColor: Colors.white,
                buttonColor: Color(0xff24414D),
                onPress: () async {
                  // await Auth.socketUtils.emitRequestRide();
                  // Function onTripDetailSRecieved = Provider.of<SocketController>(context, listen: false).onTripDetailSRecieved;
                  // await Auth.socketUtils
                  //         .listenTRIPDETAILS(onTripDetailSRecieved);
                  //     await Auth.socketUtils.listenError();
                })),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Color(0xff4CE4B1)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 5),
              //           child: Column(children: [
              //             Image.asset('assets/icons/call.png'),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Call',
              //               style: TextStyle(color: Colors.white),
              //             )
              //           ]),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: Container(
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Color(0xff4252FF)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 5),
              //           child: Column(children: [
              //             Image.asset('assets/icons/chart.png'),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Call',
              //               style: TextStyle(color: Colors.white),
              //             )
              //           ]),
              //         ),
              //       ),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Expanded(
              //       child: Container(
              //         // height: 100,
              //         decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(5),
              //             color: Color(0xffBEC2CE)),
              //         child: Padding(
              //           padding: const EdgeInsets.symmetric(
              //               vertical: 10, horizontal: 5),
              //           child: Column(children: [
              //             Image.asset('assets/icons/cancel.png'),
              //             SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               'Call',
              //               style: TextStyle(color: Colors.white),
              //             )
              //           ]),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
