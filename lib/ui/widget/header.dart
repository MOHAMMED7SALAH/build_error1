import 'package:flutter/material.dart';
import 'package:saffi/helper/style.dart';

class Header extends StatelessWidget {
  final double height;
  final double width;

  const Header({Key key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedClipper1(),
      child: Container(
        height: height,
        width: width,
        color: primaryColor,
      ),
    );
  }
}

class RoundedClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.lineTo(0, size.height * 0.3000000);
    path_0.quadraticBezierTo(size.width * 0.1990000, size.height * 1.0010000,
        size.width * 0.5000000, size.height);
    path_0.quadraticBezierTo(size.width * 0.8010000, size.height * 0.9995000,
        size.width, size.height * 0.3020000);
    path_0.lineTo(size.width, 0);

    return path_0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
