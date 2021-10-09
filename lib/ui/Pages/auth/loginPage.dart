import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/auth/SignupPage.dart';
import 'package:saffi/ui/Pages/auth/resetPasswordPage.dart';
import 'package:saffi/ui/Pages/home/MainPage.dart';

import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/navigation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    var lang = Provider.of<LangContoller>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.only(top: 0),
          children: [
            Stack(
              children: [
                Header(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: double.infinity,
                ),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.25,
                //   width: double.infinity,
                //   child: Header()
                // ),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 50,
                      ),
                      SizedBox(height: 15),
                      Text(
                        localization.text("signin"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFeild(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      hint: "exampile@gmail.com",
                      title: localization.text("Email"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        }
                        // if (!v.contains("@")) {
                        //   return loc;
                        // }
                        return null;
                      },
                    ),
                    CustomFeild(
                      keyboardType: TextInputType.visiblePassword,
                      hint: "*******",
                      title: localization.text("password"),
                      controller: passwordController,
                      password: true,
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        }
                        if (v.length < 6) {
                          return localization.text("passworedIsWeak");
                        }
                        return null;
                      },
                    ),
                    Align(
                      alignment: localization.text("lang") == "ar"
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: InkWell(
                        onTap: () => push(context, ResetPassPage()),
                        child: Text(
                          localization.text("forgotpassword"),
                          // textAlign: TextAlign.start,

                          style: TextStyle(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    loading == true
                        ? Loading
                        : CustomBtn(
                            onPressed: () => login(),
                            title: localization.text("login"),
                          ),
                    SizedBox(height: 40),
                    FlatButton(
                      onPressed: () => push(context, SignupPage()),
                      child: Text(
                        localization.text("haveacc"),
                        // textAlign: TextAlign.start,
                        style: TextStyle(
                          color: primaryColor,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Provider.of<UserController>(context, listen: false)
          .login(
        context,
        email: emailController.text,
        password: passwordController.text,
      )
          .then(
        (value) {
          if (value == true) {
            loading = false;
            removeUntil(context, MainPage());
          } else {
            setState(() {
              loading = false;
            });
          }
        },
      );
    }
  }
}
