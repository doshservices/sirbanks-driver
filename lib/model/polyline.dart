import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Polyline {
  double width;
  Color color;
  List<LatLng> points;
  Polyline({
    this.color = Colors.black,
    this.points = const <LatLng>[],
    this.width,
  });
}