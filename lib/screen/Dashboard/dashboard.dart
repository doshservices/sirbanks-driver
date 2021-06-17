import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:sirbanks_driver/constants.dart';
import 'package:sirbanks_driver/model/mapTypeModel.dart';
import 'package:permission_handler/permission_handler.dart';
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
  // Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
  CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(6.537216, 3.348890), zoom: 16);

  CircleId selectedCircle;
  GoogleMapController _mapController;

  String currentLocationName;
  String newLocationName;
  String _placemark = '';
  GoogleMapController mapController;
  // PlaceItemRes fromAddress;
  // PlaceItemRes toAddress;
  bool checkPlatform = Platform.isIOS;
  double distance = 0;
  bool nightMode = false;
  VoidCallback showPersBottomSheetCallBack;
  List<MapTypeModel> sampleData = new List<MapTypeModel>();
  PersistentBottomSheetController _controller;
  // List<Map<String, dynamic>> listRequest = List<Map<String, dynamic>>();

  // List<Routes> routesData;
  // final GMapViewHelper _gMapViewHelper = GMapViewHelper();
  Map<PolylineId, Polyline> _polyLines = <PolylineId, Polyline>{};
  PolylineId selectedPolyline;
  bool isShowDefault = false;
  Position currentLocation;
  Position _lastKnownPosition;

  // final Geolocator _locationService = Geolocator();
  // Socketio _ioScoket = locator<Socketio>();
  PermissionStatus permission;

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
//     getDriverCredentials();
//     print('Initial driver available status ================$availableStatus');
// //    _initLastKnownLocation();
// //    _initCurrentLocation();
//     fetchLocation();
//     if (mounted) {}
//     riderRequest();
//     rideRequestAccepted();
//     rideRequestTimeout();
//     tripCanceled();
    // showPersBottomSheetCallBack = _showBottomSheet;
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

    // listRequest = [
    //   {
    //     "id": '0',
    //     "avatar": "https://source.unsplash.com/1600x900/?portrait",
    //     "userName": "Olivia Nastya",
    //     "date": '08 Jan 2019 at 12:00 PM',
    //     "price": 150,
    //     "distance": "21km",
    //     "addFrom": "2536 Flying Taxicabs",
    //     "addTo": "2536 Flying Taxicabs",
    //     "locationForm": LatLng(42.535003, -71.873626),
    //     "locationTo": LatLng(42.551746, -71.958439),
    //   },
    //   {
    //     "id": '1',
    //     "avatar": "https://source.unsplash.com/1600x900/?portrait",
    //     "userName": "Callie Greer",
    //     "date": '08 Jan 2019 at 12:00 PM',
    //     "price": 150,
    //     "distance": "5km",
    //     "addFrom": "36 Flying Taxicabs",
    //     "addTo": "2536 Icie Park Suite 572",
    //     "locationForm": LatLng(42.557152, -72.023708),
    //     "locationTo": LatLng(42.460815, -72.203673),
    //   },
    //   {
    //     "id": '2',
    //     "avatar": "https://source.unsplash.com/1600x900/?portrait",
    //     "userName": "Olivia Nastya",
    //     "date": '08 Jan 2019 at 12:00 PM',
    //     "price": 152,
    //     "distance": "10km",
    //     "addFrom": "2536 Flying Taxicabs",
    //     "addTo": "2 William St, Chicago, US",
    //     "locationForm": LatLng(42.305444, -72.201658),
    //     "locationTo": LatLng(42.327784, -71.953803),
    //   },
    // ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> checkPermission() async {
    permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);
  }

  // void fetchLocation() {
  //   print('Fetch location called ==== ...>>>');
  //   checkPermission()?.then((_) {
  //     if (permission != PermissionStatus.denied) {
  //       print('Fetch location permission granted called ==== ...>>>');
  //       _initCurrentLocation();
  //     }
  //   });
  // }

  // ///Get last known location
  // Future<void> _initLastKnownLocation() async {
  //   Position position;
  //   try {
  //     final Geolocator geolocator = Geolocator()
  //       ..forceAndroidLocationManager = true;
  //     position = await geolocator?.getLastKnownPosition(
  //         desiredAccuracy: LocationAccuracy.bestForNavigation);
  //   } on PlatformException {
  //     position = null;
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //   setState(() {
  //     _lastKnownPosition = position;
  //   });
  // }

  // updateDriverlocation(double lng, double lat) {
  //   _ioScoket.sendData("default", "UPDATE_LOCATION", {
  //     "id": driverId,
  //     "role": "driver",
  //     "lon": lng,
  //     "lat": lat,
  //   });
  // }

  // driverUpdateLocation() {
  //   _ioScoket.sendData("default", "UPDATE_AVAILABILITY", {
  //     "id": driverId,
  //     "availability": availableStatus,
  //   });
  // }

  // requestRejected(String driverId, String tripId) {
  //   _ioScoket.sendData("default", "REJECT_REQUEST", {
  //     "id": driverId,
  //     "tripId": tripId,
  //   });
  //   print('Driver rejected request ====>>>>>>>');
  //   setState(() {
  //     isShowDefault = false;
  //   });
  // }

  // void riderRequest() {
  //   RxBus.register<RidersRequest>().listen((event) {
  //     print('Rider request EVENT found========${event.redersRequest}');

  //     if (event != null) {
  //       setState(() {
  //         isShowDefault = true;
  //         riderRequestData = event.redersRequest;
  //       });
  //       print(
  //           'Rider request found data types========${riderRequestData.runtimeType}');
  //     }
  //   });
  // }

  // void rideRequestTimeout() {
  //   RxBus.register<RideRequestTimeout>().listen((event) {
  //     print('RideRequestTimeout EVENT found========${event.requestTimeout}');

  //     if (event != null) {
  //       setState(() {
  //         isShowDefault = false;
  //         requestTimeout = event.requestTimeout;
  //         Fluttertoast.showToast(
  //           msg: 'You just lost a request.',
  //           toastLength: Toast.LENGTH_LONG,
  //           gravity: ToastGravity.BOTTOM,
  //         );
  //       });
  //       print(
  //           'RideRequestTimeout data types========${riderRequestData.runtimeType}');
  //     }
  //   });
  // }

  // acceptRideRequest(
  //     String driverId, String tripId, double driverLon, double driverLat) {
  //   _ioScoket.sendData('default', 'ACCEPT_REQUEST', {
  //     "id": driverId,
  //     "tripId": tripId,
  //     "lon": driverLon,
  //     "lat": driverLat,
  //   });
  // }

  // rideRequestAccepted() {
  //   RxBus.register<RideRequestAccepted>().listen(
  //     (event) => setState(
  //       () {
  //         requestAccepted = event.rideRequestAccepted;
  //         if (requestAccepted != null) {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => PickUp(
  //                 acceptedRequest: requestAccepted,
  //                 currentLocation: LatLng(
  //                     currentLocation.latitude, currentLocation.longitude),
  //               ),
  //             ),
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  // tripCanceled() {
  //   RxBus.register<TripCanceled>().listen(
  //     (event) => setState(
  //       () {
  //         tripcancledByrider = event.tripCanceled;
  //         print('tripcancledByrider accepted ===>>>>> $tripcancledByrider');
  //         if (tripcancledByrider != null) {
  //           setState(() {
  //             isShowDefault = false;
  //           });
  //           showDialog(
  //             context: context,
  //             builder: (BuildContext context) {
  //               return driverCanceledTrip(
  //                 title: 'Warning!',
  //                 message: 'Rider cancled trip.',
  //                 onpress: () {
  //                   Navigator.of(context).pushNamed(AppRoute.homeScreen);
  //                 },
  //               );
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  // }

  // driverCanceledTrip({String title, String message, Function onpress}) {
  //   return CustomDialogInfo(
  //     title: title,
  //     body: message,
  //     onTap: onpress,
  //   );
  // }

  // /// Get current location
  // Future<void> _initCurrentLocation() async {
  //   currentLocation = await _locationService.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.bestForNavigation);

  //   List<Placemark> placemarks =
  //       await _locationService.placemarkFromCoordinates(
  //           currentLocation?.latitude, currentLocation?.longitude);
  //   if (placemarks != null && placemarks.isNotEmpty) {
  //     final Placemark pos = placemarks[0];
  //     setState(() {
  //       _placemark = pos.name + ', ' + pos.thoroughfare;
  //       print('This is where you are on map ==== ...>>>$_placemark');
  //       currentLocationName = _placemark;
  //     });
  //   }
  //   if (currentLocation != null) {
  //     moveCameraToMyLocation();
  //   }
  // }

  // void moveCameraToMyLocation() {
  //   updateDriverlocation(currentLocation.longitude, currentLocation.latitude);
  //   _mapController?.animateCamera(
  //     CameraUpdate?.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(currentLocation?.latitude, currentLocation?.longitude),
  //         zoom: 17.0,
  //       ),
  //     ),
  //   );
  // }

  // void _onMapCreated(GoogleMapController controller) async {
  //   if (currentLocation != null) {
  //     updateDriverlocation(currentLocation.longitude, currentLocation.latitude);
  //   }
  //   this._mapController = controller;
  //   // addMarker(listRequest[0]['locationForm'], listRequest[0]['locationTo']);
  // }

  // Future<String> _getFileData(String path) async {
  //   return await rootBundle.loadString(path);
  // }

  // void _setMapStyle(String mapStyle) {
  //   setState(() {
  //     nightMode = true;
  //     _mapController.setMapStyle(mapStyle);
  //   });
  // }

  // void changeMapType(int id, String fileName) {
  //   print(fileName);
  //   if (fileName == null) {
  //     setState(() {
  //       nightMode = false;
  //       _mapController.setMapStyle(null);
  //     });
  //   } else {
  //     _getFileData(fileName).then(_setMapStyle);
  //   }
  // }

  // void _showBottomSheet() async {
  //   setState(() {
  //     showPersBottomSheetCallBack = null;
  //   });
  //   _controller = await _scaffoldKey.currentState.showBottomSheet((context) {
  //     return new Container(
  //         height: 300.0,
  //         child: Container(
  //           padding: EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: <Widget>[
  //                   Container(
  //                     padding: EdgeInsets.only(left: 10.0),
  //                     child: Text(
  //                       "Map type",
  //                       style: heading18Black,
  //                     ),
  //                   ),
  //                   Container(
  //                     child: IconButton(
  //                       icon: Icon(
  //                         Icons.close,
  //                         color: blackColor,
  //                       ),
  //                       onPressed: () {
  //                         Navigator.pop(context);
  //                       },
  //                     ),
  //                   )
  //                 ],
  //               ),
  //               Expanded(
  //                 child: new GridView.builder(
  //                   itemCount: sampleData.length,
  //                   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 3),
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return new InkWell(
  //                       highlightColor: primaryColor,
  //                       splashColor: Colors.blueAccent,
  //                       onTap: () {
  //                         _closeModalBottomSheet();
  //                         sampleData
  //                             .forEach((element) => element.isSelected = false);
  //                         sampleData[index].isSelected = true;
  //                         changeMapType(
  //                             sampleData[index].id, sampleData[index].fileName);
  //                       },
  //                       child: new MapTypeItem(sampleData[index]),
  //                     );
  //                   },
  //                 ),
  //               )
  //             ],
  //           ),
  //         ));
  //   });
  // }

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
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            kLoginScreen, (route) => false);
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

  // addMarker(LatLng locationForm, LatLng locationTo) {
  //   _markers.clear();
  //   final MarkerId _markerFrom = MarkerId("fromLocation");
  //   final MarkerId _markerTo = MarkerId("toLocation");
  //   _markers[_markerFrom] = GMapViewHelper.createMaker(
  //     markerIdVal: "fromLocation",
  //     icon: checkPlatform
  //         ? "assets/image/gps_point_24.png"
  //         : "assets/image/gps_point.png",
  //     lat: locationForm.latitude,
  //     lng: locationForm.longitude,
  //   );

  //   _markers[_markerTo] = GMapViewHelper.createMaker(
  //     markerIdVal: "toLocation",
  //     icon: checkPlatform
  //         ? "assets/image/ic_marker_32.png"
  //         : "assets/image/ic_marker_128.png",
  //     lat: locationTo.latitude,
  //     lng: locationTo.longitude,
  //   );
  //   // _gMapViewHelper?.cameraMove(
  //   //     fromLocation: locationForm,
  //   //     toLocation: locationTo,
  //   //     mapController: _mapController);
  // }

  // void getDriverCredentials() async {
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   setState(() {
  //     driverId = pref.getString('userId');
  //     token = pref.getString('token');
  //     firstName = pref.getString("firstname");
  //     lastName = pref.getString("lastname");
  //     phonepref = pref.getString("phone");
  //     avatar = pref.getString("avatar");
  //   });
  // }

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
              borderWidth: 1,
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
                    // isShowDefault == true
                    //     ? Container(
                    //         height: 330,
                    //         child: TinderSwapCard(
                    //             orientation: AmassOrientation.TOP,
                    //             totalNum: riderRequestData != null ? 1 : 0,
                    //             stackNum: 3,
                    //             maxWidth: MediaQuery.of(context).size.width,
                    //             minWidth: MediaQuery.of(context).size.width * 0.9,
                    //             maxHeight: MediaQuery.of(context).size.width * 0.9,
                    //             minHeight: MediaQuery.of(context).size.width * 0.85,
                    //             cardBuilder: (context, index) => ItemRequest(
                    //                   userName: riderRequestData['riderName'],
                    //                   distance: riderRequestData['distanceToRider'],
                    //                   durationToRider:
                    //                       riderRequestData['durationToRider'],
                    //                   addFrom: riderRequestData['pickUp'],
                    //                   paymentMethod:
                    //                       riderRequestData['paymentMethod'],
                    //                   locationForm: LatLng(
                    //                     double.parse(riderRequestData['pickUpLat']),
                    //                     double.parse(riderRequestData['pickUpLon']),
                    //                   ),
                    //                   locationTo: LatLng(
                    //                     double.parse(
                    //                         riderRequestData['dropOffLat']),
                    //                     double.parse(
                    //                         riderRequestData['dropOffLon']),
                    //                   ),
                    //                   onTap: () {
                    //                     acceptRideRequest(
                    //                       driverId,
                    //                       riderRequestData['tripId'],
                    //                       currentLocation.longitude,
                    //                       currentLocation.latitude,
                    //                     );
                    //                   },
                    //                   cancelTrip: () {
                    //                     requestRejected(
                    //                       driverId,
                    //                       riderRequestData['tripId'],
                    //                     );
                    //                   },
                    //                 ),
                    //             swipeUpdateCallback:
                    //                 (DragUpdateDetails details, Alignment align) {},
                    //             swipeCompleteCallback:
                    //                 (CardSwipeOrientation orientation, int index) {
                    //               /// Get orientation & index of swiped card!
                    //               print('index $index');
                    //               // print('aaa ${listRequest.length}');
                    //               // setState(() {
                    //               //   if (index == listRequest.length - 1) {
                    //               //     setState(() {
                    //               //       isShowDefault = true;
                    //               //     });
                    //               //   } else {
                    //               //     addMarker(listRequest[index + 1]['pickUp'],
                    //               //         listRequest[index + 1]['dropOff']);
                    //               //   }
                    //               // });
                    //             }),
                    //       )
                    //     :
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
