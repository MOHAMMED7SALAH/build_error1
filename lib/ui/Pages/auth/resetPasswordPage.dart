import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/header.dart';

import 'ConfirmCode.dart';

class ResetPassPage extends StatefulWidget {
  @override
  _ResetPassPageState createState() => _ResetPassPageState();
}

class _ResetPassPageState extends State<ResetPassPage> {
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Colors.blue);
    return Scaffold(
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
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
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
            child: Column(
              children: [
                Text(
                  "Enter your Email Address and we will send you code",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 20),
                CustomFeild(
                  controller: email,
                  hint: "exampile@gmail.com",
                  title: "Email Address",
                ),
                SizedBox(height: 40),
                CustomBtn(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    Provider.of<UserController>(context, listen: false)
                        .reset(context, email: email.text);
                  },
                  title: "Send Code",
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
