import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:sirbanks_driver/provider/auth.dart';
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
  LocationData _currentPosition;
  String _address, _dateTime;
  double lat, long;

  CircleId selectedCircle;
  // GoogleMapController _mapController;

  String currentLocationName;
  String newLocationName;
  // String _placemark = '';
  GoogleMapController mapController;
  Location location = Location();
  GoogleMapController _controller;

  PolylineId selectedPolyline;
  bool isShowDefault = false;

  List<bool> isSelected;
  bool availableStatus;

  String driverId;
  String token, lastName, firstName, phonepref, avatar;
  LatLng _initialcameraposition = LatLng(6.465422, 3.406448);

  _connectSocket() {
    final auth = Provider.of<Auth>(context, listen: false);
    Future.delayed(Duration(seconds: 2), () async {
      Auth.initSocket();
      await Auth.socketUtils.initSocket(auth.token, auth.user.id);
      Auth.socketUtils.connectToSocket();
      Auth.socketUtils.emitUPDATEAVAILABILITY(auth.user.id, true);
      Auth.socketUtils.listenError();
    });
  }

  onConnect(data) {
    print('********** Connected : ${data.toString()}');
  }

  onConnectError(data) {
    print('*********** onConnectError : ${data.toString()}');
  }

  onConnectTimeout(data) {
    print('********** onConnectTimeout : ${data.toString()}');
  }

  onError(data) {
    print('********* onError : ${data.toString()}');
  }

  onDisconnect(data) {
    Auth.socketUtils.socket.close();
    print('********* onDisconnect : ${data.toString()}');
  }

  @override
  void initState() {
    getLoc();
    _connectSocket();
    super.initState();
    isSelected = [true, false];
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
                            'Exit?',
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
                            '',
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
                            'Are you sure you want to exit the App?',
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
                                  return Navigator.of(context).pop(false);
                                },
                                child: Text(
                                  'No',
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
                                  title: "Yes",
                                  titleColor: Colors.white,
                                  buttonColor: Color(0xff24414D),
                                  onPress: () {
                                    return Navigator.of(context).pop(true);
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

  // void _closeModalBottomSheet() {
  //   if (_controller != null) {
  //     _controller.close();
  //     _controller = null;
  //   }
  // }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 10),
        ),
      );
    });
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
                final auth = Provider.of<Auth>(context, listen: false);
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                  if (index == 0) {
                    Auth.socketUtils.emitUPDATEAVAILABILITY(auth.user.id, false);
                    availableStatus = false;
                    print("you");
                  } else {
                    Auth.socketUtils.emitUPDATEAVAILABILITY(auth.user.id, true);
                    Auth.socketUtils.emitUPDATELOCATION(auth.user.id, lat.toString(), long.toString());
                    Auth.socketUtils.listenError();
                    availableStatus = true;
                    print("Me");
                    print("****** "+ lat.toString());
                    print("****** "+ long.toString());
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
              SizedBox(
                child: GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialcameraposition, zoom: 16),
                  mapType: MapType.normal,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                ),
              ),
              // _buildMapLayer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Align(
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

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        long = currentLocation.longitude;
        lat = currentLocation.latitude;
        _currentPosition = currentLocation;
        _initialcameraposition = LatLng(_currentPosition.latitude, _currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        _getAddress(_currentPosition.latitude, _currentPosition.longitude)
            .then((value) {
          setState(() {
            _address = "${value.first.addressLine}";
          });
        });
      });
    });
  }

  Future<List<Address>> _getAddress(double lat, double lang) async {
    final coordinates = new Coordinates(lat, lang);
    List<Address> add =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    return add;
  }

  // Widget _buildMapLayer() {
  //   return SizedBox(
  //     height: MediaQuery.of(context).size.height,
  //     child: GoogleMap(
  //       mapType: MapType.terrain,
  //       initialCameraPosition: _kGooglePlex,
  //       onMapCreated: (GoogleMapController controller) {
  //         // _controller.complete(controller);
  //       },
  //       // markers: Set.from(markers),
  //     ),
  //   );
  // }
}
