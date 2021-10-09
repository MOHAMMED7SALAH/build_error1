import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/ui/Pages/auth/loginPage.dart';
import 'package:toast/toast.dart';
import '../../controller/userController.dart';
import '../../helper/appLocalization.dart';
import '../../helper/style.dart';
import '../../model/productsModel.dart';
import 'custom_btn.dart';

class CustomAlert {
  showOptionDialog(
      {String msg,
      String btnMsg,
      Function onClick,
      BuildContext context,
      String cancel,
      Function onCancel}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            elevation: 5,
            contentPadding: EdgeInsets.only(top: 10, left: 5, right: 5),
            children: <Widget>[
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CustomBtn(
                    color: Colors.red,
                    onTap: onCancel,
                    text: cancel,
                    txtColor: Colors.white,
                  ),
                  SizedBox(width: 10),
                  CustomBtn(
                    color: Theme.of(context).primaryColor,
                    onTap: onClick,
                    text: btnMsg,
                    txtColor: Colors.white,
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }

  showCustomDialog(
      {String msg, String btnMsg, Function onClick, BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            elevation: 5,
            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
            children: <Widget>[
              Text(
                msg,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: CustomBtn(
                    color: Theme.of(context).primaryColor,
                    onTap: onClick,
                    text: btnMsg,
                    txtColor: Colors.white),
              ),
            ],
          );
        });
  }

  networckDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            elevation: 5,
            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
            children: <Widget>[
              Text(
                "تاكد بالاتصال بالانترنت",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: CustomBtn(
                    color: Theme.of(context).primaryColor,
                    onTap: () => Navigator.pop(context),
                    text: "اعادة المحاولة",
                    txtColor: Colors.white),
              ),
            ],
          );
        });
  }

  showSnackBar({BuildContext context, String title}) {
    final _snackBar = SnackBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 1,
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(_snackBar);
  }

  toast({BuildContext context, String title}) {
    Toast.show(title, context,
        duration: 1, gravity: Toast.BOTTOM, textColor: Colors.white);
  }

  addToCart(BuildContext context, {ProductDatum item}) {
    double qtp = 1;
    if (Provider.of<UserController>(context, listen: false).userModel == null) {
      showOptionDialog(
          btnMsg: "تسجيل الدخول",
          cancel: "متابعة التسوق",
          context: context,
          msg: "يجب تسجيل الدخول حتي تتمكن من الاضافة للعربة",
          onCancel: () => Navigator.pop(context),
          onClick: () => push(context, LoginPage()));
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            elevation: 5,
            contentPadding: EdgeInsets.only(top: 10, left: 10, right: 10),
            children: <Widget>[
              Text(
                localization.text("addToCart"),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(height: 20),
              Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[200]),
                  ),
                  child: StatefulBuilder(
                    builder: (context, setstate) {
                      return Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setstate(() {
                                qtp = qtp + double.parse(item.decimalNumber);
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "$qtp ${item.unite}",
                              style: boldStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (qtp != double.parse(item.decimalNumber)) {
                                setstate(() {
                                  qtp = qtp - double.parse(item.decimalNumber);
                                });
                              }
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: accentColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(16),
                                  bottomRight: Radius.circular(16),
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  )),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
                child: CustomBtn(
                  color: primaryColor,
                  text: localization.text("addToCart"),
                  // onTap: () {},
                  txtColor: Colors.white,
                  onTap: () async {
                    await Provider.of<UserController>(context, listen: false)
                        .addToCart(context, item: item, qtp: qtp)
                        .then((value) {
                      if (value == true) {
                        Navigator.pop(context);
                      }
                    });
                  },
                  // text: btnMsg,
                  // txtColor: Colors.white,
                ),
              ),
            ],
          );
        },
      );
    }
  }
}
