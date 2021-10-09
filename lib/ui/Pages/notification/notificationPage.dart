import 'package:flutter/material.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/notification/widget/notificationCard.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';

class NotifacationPage extends StatefulWidget {
  @override
  _NotifacationPageState createState() => _NotifacationPageState();
}

class _NotifacationPageState extends State<NotifacationPage> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: customAppBar(context),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Image.asset("assets/images/bell.png"),
              // SizedBox(height: 20),
              // Text(
              //   "No notification in this moment",
              //   style: lightStyle,
              // ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "الاشعارات",
                  style: boldStyle.copyWith(fontSize: 16),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return NotificationCard();
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}
