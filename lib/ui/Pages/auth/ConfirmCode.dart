import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';

class ConfirmCode extends StatefulWidget {
  @override
  _ConfirmCodeState createState() => _ConfirmCodeState();
}

class _ConfirmCodeState extends State<ConfirmCode> {
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                child: Image.asset(
                  "assets/images/heder.png",
                  fit: BoxFit.fill,
                ),
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
                      "Enter the Code",
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
                SizedBox(height: 40),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 60,
                    fieldWidth: 60,
                    activeFillColor: Colors.grey[100],
                    borderWidth: 1,
                    disabledColor: Colors.grey[100],
                    selectedFillColor: Colors.grey[100],
                    inactiveFillColor: Colors.grey[100],
                    inactiveColor: Colors.black,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Color(0x00000000),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      // currentText = value;
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  "I didn't Recive Code",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 20),
                Text(
                  "Resend Code",
                  style: TextStyle(color: accentColor),
                ),
                SizedBox(height: 40),
                CustomBtn(
                  title: "Keep Going",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
