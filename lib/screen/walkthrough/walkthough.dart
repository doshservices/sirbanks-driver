import 'dart:async';
import "package:flutter/material.dart";
import 'package:sirbanks_driver/utils/shared/rounded_raisedbutton.dart';

import '../../constants.dart';
import '../../model/slide.dart';
import './widget/slide_item.dart';
import './widget/slide_dots.dart';

class WalkThrough extends StatefulWidget {
  @override
  _WalkThroughState createState() => _WalkThroughState();
}

class _WalkThroughState extends State<WalkThrough> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer timer;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(_currentPage,
          duration: Duration(microseconds: 300), curve: Curves.easeIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //Expanded(child: Container()),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      onPageChanged: _onPageChanged,
                      controller: _pageController,
                      itemCount: Slide.slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 55,
                    width: double.infinity,
                    child: RoundedRaisedButton(
                      // circleborderRadius: 10,
                      title: "Skip",
                      titleColor: Colors.white,
                      buttonColor: Color(0xff24414D),
                      onPress: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            KEnableLocationScreen, (route) => false);
                        // Navigator.of(context).pushNamed(kLoginScreen);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < Slide.slideList.length; i++)
                          if (i == _currentPage)
                            SlideDots(true)
                          else
                            SlideDots(false)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
