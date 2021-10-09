import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

// ignore: non_constant_identifier_names
Widget Loading = Center(
  child: Lottie.asset(
    "assets/svg/loading.json",
    width: 200,
  ),
);

// ignore: non_constant_identifier_names
Widget LoaderPhoto({double heghit, double width}) {
  return Center(
      child: Lottie.asset('assets/svg/loadingPhoto.json',
          width: width ?? double.infinity, height: heghit ?? double.infinity));
}
