import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final List images;

  const SliderWidget({Key key, this.images}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Carousel(
      images: images,
      dotSize: 4.0,
      dotSpacing: 15.0,
      dotColor: Colors.white,
      dotIncreasedColor: Theme.of(context).primaryColor,
      indicatorBgPadding: 5.0,
      // dotHorizontalPadding: 10,
      // dotIncreaseSize: 15,

      dotBgColor: Color(0x00000000),
      borderRadius: false,
      moveIndicatorFromBottom: 180.0,
      noRadiusForIndicator: false,
      overlayShadow: true,
      overlayShadowColors: Theme.of(context).primaryColor,
      overlayShadowSize: 0.7,
      animationDuration: Duration(seconds: 1),
      autoplayDuration: Duration(seconds: 3),
    );
  }
}
