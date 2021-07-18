import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/model/mapTypeModel.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:sirbanks_driver/screen/Dashboard/widget/myActivity.dart';
import 'package:sirbanks_driver/utils/shared/appDrawer.dart';
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final String screenName = "HOME";
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(6.537216, 3.348890), zoom: 16);

  CircleId selectedCircle;
  GoogleMapController _mapController;

  String currentLocationName;
  String newLocationName;
  String _placemark = '';
  GoogleMapController mapController;
  bool checkPlatform = Platform.isIOS;
  double distance = 0;
  bool nightMode = false;
  VoidCallback showPersBottomSheetCallBack;
  List<MapTypeModel> sampleData = new List<MapTypeModel>();
  PersistentBottomSheetController _controller;
  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  PolylineId selectedPolyline;
  bool isShowDefault = false;
  
  List<bool> isSelected;
  bool availableStatus;

  String driverId;
  String token, lastName, firstName, phonepref, avatar;
  var riderRequestData;
  var requestTimeout;
  var requestAccepted;
  var tripcancledByrider;
  String rideTripId;

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    sampleData.add(MapTypeModel(1, true, 'assets/style/maptype_nomal.png',
        'Nomal', 'assets/style/nomal_mode.json'));
    sampleData.add(MapTypeModel(2, false, 'assets/style/maptype_silver.png',
        'Silver', 'assets/style/sliver_mode.json'));
    sampleData.add(MapTypeModel(3, false, 'assets/style/maptype_dark.png',
        'Dark', 'assets/style/dark_mode.json'));
    sampleData.add(MapTypeModel(4, false, 'assets/style/maptype_night.png',
        'Night', 'assets/style/night_mode.json'));
    sampleData.add(MapTypeModel(5, false, 'assets/style/maptype_netro.png',
        'Netro', 'assets/style/netro_mode.json'));
    sampleData.add(MapTypeModel(6, false, 'assets/style/maptype_aubergine.png',
        'Aubergine', 'assets/style/aubergine_mode.json'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Container(
              height: 200,
              child: Column(
                children: [
                  Container(
                      height: 60,
                      color: Color(0xff24414D),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'Logout?',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Confirm Logout',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
                  Container(
                      height: 60,
                      color: Color(0xffF2F2F2),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            'You will now  be in Offline mode if you proceed',
                            style: TextStyle(
                                fontSize: 13,
                                color: Color(0xffFB5448),
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      )),
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
                                  Navigator.of(context).pop();
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
                                // height: 55,
                                width: 150,
                                child: RoundedRaisedButton(
                                  // circleborderRadius: 10,
                                  title: "Logout",
                                  titleColor: Colors.white,
                                  buttonColor: Color(0xff24414D),
                                  onPress: () {
                                    Navigator.of(context).pushNamedAndRemoveUntil(kLoginScreen, (route) => false);
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
          ),
        )) ??
        false;
  }

  void _closeModalBottomSheet() {
    if (_controller != null) {
      _controller.close();
      _controller = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // riderRequest();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: new MenuScreens(activeScreenName: screenName),
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
              _scaffoldKey.currentState.openDrawer();
            },
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ToggleButtons(
              borderColor: Colors.grey,
              fillColor: Color(0xff24414D),
              borderWidth: 2,
              selectedBorderColor: Colors.black,
              selectedColor: Colors.white,
              borderRadius: BorderRadius.circular(50),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Offline',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Online',
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
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              _buildMapLayer(),
              Align(
                alignment: Alignment.bottomCenter,
                child:
                    Align(
                  alignment: Alignment.bottomCenter,
                  child: MyActivity(
                    userImage: null,
                    userName: '$firstName ',
                    level: '',
                    totalEarned: '\0',
                    hoursOnline: 0.0,
                    totalDistance: '',
                    totalJob: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapLayer() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.terrain,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          // _controller.complete(controller);
        },
        // markers: Set.from(markers),
      ),
    );
  }
}
