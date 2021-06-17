import 'package:flutter/material.dart';

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: isActive ? 10 : 10,
      width: isActive ? 10 : 10,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff24414D) : Color(0xffC4C4C4),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
