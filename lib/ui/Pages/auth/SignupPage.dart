import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/auth/loginPage.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/header.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                        localization.text("SignUP"),
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFeild(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        }
                        return null;
                      },
                      title: localization.text("fullName"),
                      hint: "JONE MICLE",
                    ),
                    CustomFeild(
                      hint: "exampile@gmail.com",
                      title: localization.text("email"),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        }
                        // if (!v.contains("@")) {
                        //   return "${lang.getWord("9")} is validate";
                        // }
                        return null;
                      },
                    ),
                    CustomFeild(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      hint: "+20xxxxxx",
                      title: localization.text("phone"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        }

                        return null;
                      },
                    ),
                    CustomFeild(
                      hint: "*******",
                      title: localization.text("password"),
                      controller: passwordController,
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        }
                        if (v.length < 6) {
                          return localization.text("passworedIsWeak");
                        }
                        return null;
                      },
                      password: true,
                    ),
                    SizedBox(height: 40),
                    loading == true
                        ? Loading
                        : CustomBtn(
                            title: localization.text("creatacc"),
                            onPressed: () => register(),
                          ),
                    SizedBox(height: 40),
                    FlatButton(
                      onPressed: () => push(context, LoginPage()),
                      child: Text(
                        localization.text("haveaxc"),
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

  register() {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Provider.of<UserController>(context, listen: false)
          .register(
        context,
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        phone: phoneController.text,
      )
          .then((value) {
        if (value == true) {
          loading = false;
          push(context, LoginPage());
        } else {
          setState(() {
            loading = false;
          });
        }
      });
    }
  }
}
