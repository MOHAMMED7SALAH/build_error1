import 'package:flutter/material.dart';
import 'package:saffi/helper/style.dart';

class CustomBtn extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final Color textColor;
  final Color borderColor;
  final Color color;
  const CustomBtn({
    Key key,
    @required this.title,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.textColor,
    this.color,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.07,
      child: FlatButton(
        color: color ?? primaryColor,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          side:
              BorderSide(color: borderColor ?? color ?? primaryColor, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: textColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
