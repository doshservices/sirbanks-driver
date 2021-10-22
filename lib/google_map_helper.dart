import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:latlong/latlong.dart' ;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'dart:typed_data';


class MapBoxScreen extends StatefulWidget {
  @override
  _MapBoxScreenState createState() => _MapBoxScreenState();
}

class _MapBoxScreenState extends State<MapBoxScreen> {
  double _originLatitude, _originLongitude;
  double _destLatitude, _destLongitude;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  bool _isSearchProcessing = false;

  StreamSubscription _locationSubscription;
  GoogleMapController _mapController;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  // var points = <LatLng>[
  //   new LatLng(35.22, -101.83),
  //   new LatLng(32.77, -96.79),
  //   new LatLng(29.33, -95.36),
  //   // new LatLng(29.42, -98.49),
  //   // new LatLng(35.22, -101.83),]

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isSearchProcessing
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(37.42796133580664, -122.085749655962),
                  zoom: 14.4746,
                ),
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
                // circles: Set.of((circle != null) ? [circle] : []),
                onMapCreated: _onMapCreated,
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: IconButton(
                    onPressed: () {
                      // _closeMap(context);
                    },
                    icon: Icon(Icons.close, color: Colors.teal)),
              )
            ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.location_searching),
          onPressed: () {
            _initMarkers();
          setState(() {});
            // _searchDialog(context);
          }),
    );
  }

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
  }

  _searchDialog(context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container();
            // Search(query: widget.trackingNumber);
          },
        ),
      ),
    ).then(
      (value) {
        if (value != null) {
          _initMarkers();
          setState(() {});
        }
      },
    );
  }

  //initialized marker and polylines
  _initMarkers() {
    _originLatitude = double.parse('35.22');
    _originLongitude = double.parse('-101.83');
    _destLatitude = double.parse('29.42');
    _destLongitude = double.parse('-98.49');

    /// origin marker
    _addMarker(LatLng(_originLatitude, _originLongitude), "Pickup",
        BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(LatLng(_destLatitude, _destLongitude), "Destination",
        BitmapDescriptor.defaultMarkerWithHue(118));

    _getPolyline();
  }

//get cordinates
  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyCgeGrZMAyo5CWsgP6YcYTYaHmVcDkRYB4",
      PointLatLng(_originLatitude, _originLongitude),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.driving,
      //wayPoints: [PolylineWayPoint(location: "$pickupAddress")],
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

//polyling functions

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

//add pickup and destination markers
  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
      infoWindow: InfoWindow(
        title: "$id",
      ),
    );
    markers[markerId] = marker;
  }

}


// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'Components/decodePolyline.dart';

// class GMapViewHelper {

//   GMapViewHelper();

//   Widget buildMapView({
//     @required BuildContext context,
//     @required Map<MarkerId, Marker> markers,
//     Map<PolylineId, Polyline> polyLines = const <PolylineId, Polyline>{},
//     MapCreatedCallback onMapCreated,
//     ArgumentCallback<LatLng> onTap,
//     @required LatLng currentLocation
//   }) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height,
//       child: GoogleMap(
//         onMapCreated: onMapCreated,
//         onTap: onTap,
//         markers: Set<Marker>.of(markers.values),
//         polylines: Set<Polyline>.of(polyLines.values),
//         myLocationEnabled: true,
//         myLocationButtonEnabled: false,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(currentLocation.latitude, currentLocation.longitude),
//           zoom: 12.0,
//         ),
//       ),
//     );
//   }

//   static Marker createMaker ({
//     @required String markerIdVal,
//     @required String icon,
//     @required double lat,
//     @required double lng, GestureTapCallback onTap,}){
//     final MarkerId markerId = MarkerId(markerIdVal);

//     final Marker marker = Marker(
//         markerId: markerId,
//         position: LatLng(lat, lng),
//         icon: BitmapDescriptor.fromAsset(icon),
//         onTap: onTap
//     );

//     return marker;
//   }

//   static Polyline createPolyline ({
//     @required String polylineIdVal,
//     @required final router,
//     @required LatLng formLocation,
//     @required LatLng toLocation,
//   }){
//     List<LatLng> listPoints = <LatLng>[];
//     List<dynamic> _points = <dynamic>[];
//     List<dynamic> latLong = <dynamic>[];
//     List<dynamic> lngLong = <dynamic>[];
//     final PolylineId polylineId = PolylineId(polylineIdVal);

//     LatLng _createLatLng(double lat, double lng) {
//       return LatLng(lat, lng);
//     }

//     var _router = decode(router);
//     for (int lat = 0; lat < _router.length; lat += 2) {
//       latLong.add(_router[lat]);
//     }
//     for (int lng = 1; lng < _router.length; lng += 2) {
//       lngLong.add(_router[lng]);
//     }
//     for (int i = 0; i < latLong.length; i++) {
//       _points.add([latLong[i], lngLong[i]]);
//     }
//     for (int i = 0; i < _points.length; i++) {
//       listPoints.add(_createLatLng(_points[i][0], _points[i][1]));
//     }

//     final Polyline polyline = Polyline(
//       polylineId: polylineId,
//       consumeTapEvents: true,
//       color: Color(0xFF669df6),
//       width: 6,
//       points: listPoints,
//     );
//     return polyline;
//   }

//   void cameraMove({
//     @required LatLng fromLocation,
//     @required LatLng toLocation,
//     @required GoogleMapController mapController,

//   }) async {
//     var _latFrom = fromLocation.latitude;
//     var _lngFrom = fromLocation.longitude;
//     var _latTo = toLocation.latitude;
//     var _lngTo = toLocation.longitude;
//     var sLat, sLng, nLat, nLng;

//     if(_latFrom <= _latTo) {
//       sLat = _latFrom;
//       nLat = _latTo;
//     } else {
//       sLat = _latTo;
//       nLat = _latFrom;
//     }

//     if(_lngFrom <= _lngTo) {
//       sLng = _lngFrom;
//       nLng = _lngTo;
//     } else {
//       sLng = _lngTo;
//       nLng = _lngFrom;
//     }

//     return mapController?.animateCamera(
//       CameraUpdate?.newLatLngBounds(
//         LatLngBounds(
//           southwest: LatLng(sLat, sLng),
//           northeast: LatLng(nLat, nLng),
//         ),
//         16.0,
//       ),
//     );
//   }
// }
