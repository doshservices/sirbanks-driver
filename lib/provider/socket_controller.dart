import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';
import 'package:sirbanks_driver/utils/socket_utils.dart';

class SocketController with ChangeNotifier {
  static SocketUtils socketUtils;
  // GetTripDetailModel getTripDetailModel;
  // List<DriverLocModel> driverlocModel = [];
  Map<String, dynamic> getTrip;
  // IncomingCall incomingCall;
  int onlinePractitionerscount = 0;
  dynamic currentPatientOnCallSocket;

  // void endIncomingCall() {
  //   incomingCall = null;
  //   notifyListeners();
  // }
  // static initSocket() {
  //   if (null == socketUtils) {
  //     socketUtils = SocketUtils();
  //   }
  // }

  void setCurrentPatientOnCallSocket(dynamic socket) {
    currentPatientOnCallSocket = socket;
    notifyListeners();
  }

  registerPractitionerListeners() {
    // Auth.socketUtils.listenForNewCare(onTripDetailSRecieved);
  }

  // registerPatientListeners() {
  //   Auth.socketUtils.listenForIncomingCall(onIncomingCallRecieved);
  //   Auth.socketUtils.listenForOnlinePractitioners(onOnlinePractitionersRecieved);
  // }

  // onIncomingCallRecieved(data) {
  //   print("new incoming call");
  //   debugPrint(data.toString(), wrapWidth: 1025);
  //   incomingCall = IncomingCall(
  //     roomId: data["roomId"],
  //     token: data["token"],
  //     practitionerName: data["practitionerName"],
  //     socket: data["socket"],
  //   );
  //   notifyListeners();
  // }

  // onOnlinePractitionersRecieved(data) {
  //   print("updated practitioner list");
  //   onlinePractitionerscount = data.length;
  //   print(data.length);

  //   debugPrint(data.toString(), wrapWidth: 1025);

  //   notifyListeners();
  // }

  onRIDEREQUESTSRecieved(String datavalue) {
    print("new video arrived");
    print(datavalue);
    // print("+++++++++++"+ datavalue['duration'].toString());
    
    // print("+++++++++++");
    var data = jsonDecode(datavalue);
    if(data!=null){
    
    Get.defaultDialog(
      title: '',
      titleStyle: TextStyle(fontSize: 1),
      content: Container(
          height: 260,
          child: Column(
            children: [
              Container(
                  height: 50,
                  color: Color(0xff24414D),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Text(
                        'Request',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '-You hvae 1 new requests',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              Expanded(
                child: Container(
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
                              data['dropOff'].toString(),
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
                              data['pickUp'].toString(),
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
                              '${data['durationToRider'].toString()} /${data['distanceToRider'].toString()}',
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
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              return Get.back();
                            },
                            child: Text(
                              'Ignore',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff24414D),
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: EdgeInsets.all(10),
                            height: 50,
                            width: 120,
                            child: RoundedRaisedButton(
                              // circleborderRadius: 10,
                              title: "Accept",
                              titleColor: Colors.white,
                              buttonColor: Color(0xff24414D),
                              onPress: () {
                                // Auth.socketUtils.emitACCEPTREQUEST(
                                //     data['tripId'],
                                //     auth.user.id,
                                //     lat.toString(),
                                //     long.toString());
                                // return Navigator.of(context).pop(true);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );}
    // showRideDialog(Map<String, dynamic> data) {
    // final auth = Provider.of<Auth>(context, listen: false);
    // // {"tripId":"66753fea-489e-41c5-823a-c6d19bd81911","riderId":"6108edba6c46f6001c4d3818",
    // // "riderName":"jephtah","distanceToRider":"12.1 km","durationToRider":"21 mins",
    // // "driverId":"6126464b4fa00f001d025c09","pickUp":"Oshodi Bus Terminal Lagos",
    // // "pickUpLon":"3.349149","pickUpLat":"6.605874","dropOff":"Ikeja along bus lagos",
    // // "dropOffLon":"32.45","dropOffLat":"12.44"}
    // showDialog(
    //   context: context,
    //   builder: (context) => Dialog(
    //     child: 
    //   ),
    // );
    // if(data!=null){
    //   GetTripDetailModel getTripDetail = GetTripDetailModel();
    // getTripDetail.duration = data['duration'];
    // getTripDetail.distance = data['distance'];
    // getTripDetail.lowerEstimate = data['estimatedFare']['lowerEstimate'];
    // getTripDetail.higherEstimate = data['estimatedFare']['higherEstimate'];
    // if(data["drivers"]!=null){
    //   List<dynamic> entities = data["drivers"];
    //  entities.forEach((entity) {
    //    DriverLocModel driverLoc = DriverLocModel();
    //    driverLoc.lat = entity['lat'];
    //    driverLoc.long = entity['lon'];

    //    driverlocModel.add(driverLoc);
    //  });

    //   getTripDetail.driverLocation = driverlocModel;
    // }else{
    //   getTripDetail.driverLocation = driverlocModel;
    // }

    // getTripDetailModel = getTripDetail;
    
    // }
    
    notifyListeners();
  }
}