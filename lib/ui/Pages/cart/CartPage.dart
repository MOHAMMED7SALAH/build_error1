import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/repo/NetworkUtlis.dart';
import 'package:saffi/ui/Pages/user/address/addressUser.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/networkImage.dart';

import 'emptyCart.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool emptyCart = false;
  double shippingCost = 0;
  @override
  void initState() {
    emptyCart = false;
    shopping();
    super.initState();
  }

  shopping() async {
    Response response = await NetworkUtil().get("shipping_cost.php");
    shippingCost = double.parse(json.decode(response.data)["shipping_cost"]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserController>(context, listen: true);
    var lang = Provider.of<LangContoller>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(context,
            withDrawer: true, title: localization.text("cart")),
        body: userProvider.userCart.length == 0 || userProvider.userCart == null
            ? EmptyCart()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: localization.text("enterCodeVoucher"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffix: InkWell(
                          onTap: () {},
                          child: Text(localization.text("APPLY")),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: List.generate(
                      userProvider.userCart.length,
                      (index) {
                        var item = userProvider.userCart[index];
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: Card(
                            margin: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  height: 120,
                                  width: 120,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: networkImage("${item.mainImg}")),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item.name}",
                                        maxLines: 1,
                                        style: lightStyle.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "ج.م ${item.price}",
                                        style: boldStyle.copyWith(
                                            color: accentColor),
                                      ),
                                      Text(
                                        "Total : ج.م ${double.parse(item.price) * double.parse(item.qtp)} ",
                                        style: boldStyle.copyWith(
                                            color: accentColor),
                                      ),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // CustomAlert().addToCart(context,
                                              //     item: item);
                                              userProvider.addToCart(context,
                                                  item: item, qtp: 1);
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                              "${item.qtp} ${item.unite ?? ""}"),
                                          SizedBox(width: 10),
                                          InkWell(
                                            onTap: () {
                                              userProvider.delFromCart(
                                                context,
                                                item: item,
                                              );
                                              setState(() {});
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                                size: 15,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${localization.text("tax")} : $shippingCost ج.م",
                                style: lightStyle,
                              ),
                              Text(
                                "${localization.text("totalprice")}",
                                style: lightStyle,
                              ),
                              Text(
                                "ج.م" +
                                    "${(shippingCost + userProvider.totalcart).toStringAsFixed(1)}",
                                style: boldStyle.copyWith(color: accentColor),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: CustomBtn(
                            title: localization.text("Continue"),
                            color: primaryColor,
                            onPressed: () {
                              push(
                                  context,
                                  MyAddressPage(
                                    chckout: true,
                                    type: 0,
                                    id: null,
                                  ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
