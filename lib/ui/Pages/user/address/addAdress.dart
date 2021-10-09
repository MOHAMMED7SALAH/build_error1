import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/controller/userPlacesController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/succPage.dart';
import 'package:saffi/ui/Pages/home/MainPage.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';

class AddAdress extends StatefulWidget {
  @override
  _AddAdressState createState() => _AddAdressState();
}

class _AddAdressState extends State<AddAdress> {
  final GlobalKey<FormState> _form = GlobalKey();
  final cityController = TextEditingController();
  final zoonController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final streetController = TextEditingController();
  final buildController = TextEditingController();
  final storeyController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserController>(context, listen: true);
    var lang = Provider.of<LangContoller>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(context),
        body: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Form(
                key: _form,
                child: Column(
                  children: [
                    CustomFeild(
                      controller: nameController,
                      hint: localization.text("home"),
                      keyboardType: TextInputType.name,
                      title: localization.text("placeName"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        } else {
                          return null;
                        }
                      },
                    ),
                    // if (user.userModel == null)
                    // CustomFeild(
                    //   controller: phoneController,
                    //   hint: "01000",
                    //   keyboardType: TextInputType.number,
                    //   title: "${lang.getWord("10")}",
                    //   validator: (v) {
                    //     if (v.isEmpty) {
                    //       return "phone is required";
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    CustomFeild(
                      controller: cityController,
                      hint: localization.text("hintCity"),
                      keyboardType: TextInputType.name,
                      title: localization.text("city"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomFeild(
                      controller: zoonController,
                      hint: "Nasr City",
                      keyboardType: TextInputType.name,
                      title: localization.text("zone"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomFeild(
                      controller: streetController,
                      hint: "abbas al aqad",
                      keyboardType: TextInputType.name,
                      title: localization.text("street"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomFeild(
                      controller: buildController,
                      hint: "20",
                      keyboardType: TextInputType.name,
                      title: localization.text("numEmara"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomFeild(
                      controller: storeyController,
                      hint: localization.text("story"),
                      keyboardType: TextInputType.name,
                      title: localization.text("story"),
                      validator: (v) {
                        if (v.isEmpty) {
                          return localization.text("thisFieldisrequred");
                        } else {
                          return null;
                        }
                      },
                    ),
                    CustomBtn(
                      title: localization.text("add"),
                      onPressed: () async {
                        if (_form.currentState.validate()) {
                          Provider.of<PlasesController>(context, listen: false)
                              .addPlaces(
                            context,
                            cityController.text,
                            zoonController.text,
                            streetController.text,
                            buildController.text,
                            storeyController.text,
                            nameController.text,
                          )
                              .then((value) {
                            if (value == true) {
                              Navigator.pop(context);
                            }
                          });
                        }
                      },
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
