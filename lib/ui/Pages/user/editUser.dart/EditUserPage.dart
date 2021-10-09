import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/userModel.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';

import 'editPassword.dart';

class EditUsarPage extends StatefulWidget {
  @override
  _EditUsarPageState createState() => _EditUsarPageState();
}

class _EditUsarPageState extends State<EditUsarPage> {
  bool loading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    User user =
        Provider.of<UserController>(context, listen: false).userModel.user;
    emailController.text = user.email;
    nameController.text = user.name;
    phoneController.text = user.phone;

    super.initState();
  }

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
                localization.text("editProfile"),
                style: boldStyle.copyWith(fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 20),
          Form(
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
                  title: localization.text("Email"),
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (v) {
                    if (v.isEmpty) {
                      return localization.text("thisFieldisrequred");
                    }
                    return null;
                  },
                ),
                CustomFeild(
                  keyboardType: TextInputType.phone,
                  controller: phoneController,
                  hint: "+20xxxxxx",
                  title: "${localization.text("phone")}",
                  validator: (v) {
                    if (v.isEmpty) {
                      return "${localization.text("thisFieldisrequred")}";
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () => push(context, EditPasswordPage()),
                    child: Text(
                      localization.text("editPassword"),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                SizedBox(height: 40),
                loading == true
                    ? Loading
                    : CustomBtn(
                        title: localization.text("save"),
                        onPressed: () => editUser(),
                      ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  editUser() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        loading = true;
      });
      Provider.of<UserController>(context, listen: false)
          .editUserData(
        context,
        email: emailController.text,
        name: nameController.text,
        password: passwordController.text,
        phone: phoneController.text,
      )
          .then((value) {
        if (value == true) {
          loading = false;
          Navigator.pop(context);
        } else {
          setState(() {
            loading = false;
          });
        }
      });
    }
  }
}
