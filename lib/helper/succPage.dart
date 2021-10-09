import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/home/MainPage.dart';

class SuccPage extends StatefulWidget {
  @override
  _SuccPageState createState() => _SuccPageState();
}

class _SuccPageState extends State<SuccPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      removeUntil(context, MainPage());
    });
    super.initState();
  }

  @override

  ///
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset("assets/svg/succ.json"),
            SizedBox(height: 20),
            Text(
              "تم ارسال طلبك بنجاح",
              style: boldStyle.copyWith(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
