import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomReateStar.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/custom_alert.dart';

class AddRatePage extends StatefulWidget {
  final String id;

  const AddRatePage({Key key, this.id}) : super(key: key);
  @override
  _AddRatePageState createState() => _AddRatePageState();
}

class _AddRatePageState extends State<AddRatePage> {
  final comment = TextEditingController();
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: ListView(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.1, right: 20, left: 20),
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  localization.text("whatisyourreview"),
                  style: lightStyle.copyWith(fontSize: 25),
                ),
                SizedBox(height: 10),
                CustomReateBar(
                  onRated: (v) {
                    setState(() {
                      rate = v;
                    });
                  },
                  size: 50,
                  rate: rate,
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
          Text(
            localization.text("Whatcanweimprove"),
            style: lightStyle.copyWith(fontSize: 20),
          ),
          SizedBox(height: 15),
          TextFormField(
            maxLines: 7,
            controller: comment,
            decoration: InputDecoration(
              hintText: "Good quality & very original product",
              fillColor: Colors.white,
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            ),
          ),
          SizedBox(height: 50),
          Provider.of<UserController>(context, listen: true).loaging == true
              ? Loading
              : CustomBtn(
                  title: localization.text("add"),
                  color: primaryColor,
                  onPressed: () {
                    if (rate != 0 && comment.text.length != 0) {
                      Provider.of<UserController>(context, listen: false)
                          .addreat(
                              context, widget.id, comment.text, rate.toString())
                          .then((value) {
                        if (value == true) {
                          Navigator.pop(context);
                        }
                      });
                    } else {
                      CustomAlert().toast(
                          context: context,
                          title: localization
                              .text("Thedatamustbefilledoutcorrectly"));
                    }
                  },
                )
        ],
      ),
    );
  }
}
