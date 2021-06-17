import 'package:flutter/material.dart';

class Slide {
  final String imageUrl;
  final String title;
  final String subtitle;

  Slide({
    @required this.imageUrl,
    @required this.title,
    @required this.subtitle,
  });

  static final slideList = [
    Slide(
      imageUrl: "assets/images/walkthrough1.png",
      title: "Accept a ride",
      subtitle: "Amet minim mollit non deserunt\n ullamco est sit aliqua d"
    ),
    Slide(
      imageUrl: "assets/images/walkthrough2.png",
      title: "Real -Time Tracking",
      subtitle: "Amet minim mollit non deserunt\n ullamco est sit aliqua d"
    ),
    Slide(
      imageUrl: "assets/images/walkthrough3.png",
      title: "Earn money",
      subtitle: "Amet minim mollit non deserunt\n ullamco est sit aliqua d"
      ),
  ];
}
