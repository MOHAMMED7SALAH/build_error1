import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';

class EditPasswordPage extends StatefulWidget {
  @override
  _EditPasswordPageState createState() => _EditPasswordPageState();
}

class _EditPasswordPageState extends State<EditPasswordPage> {
  final newPassword = TextEditingController();
  final oldPassword = TextEditingController();
  final reNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LangContoller>(context, listen: true);
    return Scaffold(
      appBar: customAppBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                height: 30,
                width: 3,
                color: primaryColor,
              ),
              Text(
                localization.text("editPassword"),
                style: boldStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          CustomFeild(
            hint: "*******",
            title: localization.text("newPassword"),
            controller: newPassword,
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
          CustomFeild(
            hint: "*******",
            title: localization.text("confirmPassword"),
            controller: reNewPassword,
            validator: (v) {
              if (v.isEmpty) {
                return localization.text("thisFieldisrequred");
              }
              if (v == newPassword.text) {
                return localization.text("Passworddoesnotmatch");
              }
              return null;
            },
            password: true,
          ),
          CustomFeild(
            hint: "*******",
            title: localization.text("oldPassword"),
            controller: oldPassword,
            validator: (v) {
              if (v.isEmpty) {
                return localization.text("thisFieldisrequred");
              }
              return null;
            },
            password: true,
          ),
          SizedBox(height: 20),
          Provider.of<UserController>(context, listen: true).loaging == true
              ? Loading
              : CustomBtn(
                  title: localization.text("save"),
                  onPressed: () {
                    Provider.of<UserController>(context, listen: false)
                        .editUserPassword(context,
                            confirmPass: reNewPassword.text,
                            newPassword: newPassword.text,
                            oldPassword: oldPassword.text)
                        .then((value) {
                      if (value == true) {
                        Navigator.pop(context);
                      }
                    });
                  },
                )
        ],
      ),
    );
  }
}
