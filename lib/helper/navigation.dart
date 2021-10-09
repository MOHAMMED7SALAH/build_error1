import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

push(BuildContext context, Widget child) {
  return Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => child,
  ));
}

removeUntil(BuildContext context, Widget child) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => child,
      ),
      (route) => false);
}

pushReplacement(BuildContext context, Widget child) {
  return Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) => child,
  ));
}
