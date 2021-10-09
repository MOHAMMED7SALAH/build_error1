import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/ui/Pages/auth/loginPage.dart';
import 'package:saffi/ui/Pages/home/MainPage.dart';

import '../../../helper/style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      init();
    });
    super.initState();
  }

  init() async {
    await Provider.of<LangContoller>(context, listen: false)
        .getStorgeLang(context)
        .then((value) {
      Provider.of<UserController>(context, listen: false)
          .getUserData(context)
          .then((value) {
        if (value == true) {
          Provider.of<UserController>(context, listen: false)
              .getUserCart(context);
          removeUntil(context, MainPage());
        } else {
          removeUntil(context, MainPage());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/logo.png",
          // height: double.infinity,
          width: 200,
          height: 200,
          // width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
