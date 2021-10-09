import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';

import 'package:intl/intl.dart' as time;

class MyOrderPage extends StatefulWidget {
  final bool drawer;

  const MyOrderPage({Key key, this.drawer}) : super(key: key);
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
  bool vis = false;
  @override
  void initState() {
    Provider.of<UserController>(context, listen: false).getUserOrders(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(context, title: localization.text("MyOrders")),
        body: userController.loaging == true
            ? Loading
            : userController.userOrders.isEmpty
                ? Center(child: Image.asset("assets/images/errorpage.png"))
                : ListView(
                    padding: EdgeInsets.only(
                        top: 30, right: 15, left: 15, bottom: 70),
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 25,
                            width: 3,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            color: primaryColor,
                          ),
                          Text(
                            localization.text("orderStatus"),
                            style: boldStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Column(
                        children: List.generate(
                          userController.userOrders.length,
                          (index) {
                            var item = userController.userOrders[index];
                            return InkWell(
                              onTap: () async {
                                await userController.getorderItems(
                                    context, item.id);
                                for (int i = 0;
                                    i < userController.userOrders.length;
                                    i++) {
                                  if (i == index) {
                                    setState(() {
                                      userController.userOrders[i].vis = true;
                                    });
                                  } else {
                                    setState(() {
                                      userController.userOrders[i].vis = false;
                                    });
                                  }
                                }
                              },
                              child: AnimatedContainer(
                                duration: Duration(microseconds: 500),
                                margin: EdgeInsets.symmetric(vertical: 10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 2,
                                      color: Colors.grey[300],
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.circle,
                                                size: 8,
                                                color: Colors.green,
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "${item.id}" + "#",
                                                style: boldStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                              SizedBox(width: 5),
                                              Text(
                                                "${item.orderStatus}",
                                                style: boldStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${time.DateFormat("dd/MM/yyyy").format(item.date)} ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (item.vis == true)
                                      Column(
                                        children: [
                                          Column(
                                            children: List.generate(
                                              userController.orderItems.length,
                                              (index) {
                                                var it = userController
                                                    .orderItems[index];

                                                return Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: Colors
                                                                .grey[200],
                                                            width: 1)),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          "${it.name}",
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "${it.qty} X ${it.price}",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            Text(
                                                              "${it.total} " +
                                                                  "LE",
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                localization.text("tax"),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                "",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                localization.text("totalprice"),
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Text(
                                                "${userController.totalOrderItems} ",
                                                style: boldStyle.copyWith(
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.grey[300],
                                            height: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                localization
                                                    .text("deliverDetils"),
                                                style: boldStyle.copyWith(
                                                    fontSize: 16,
                                                    color: primaryColor),
                                              ),
                                              Row(
                                                children: [
                                                  // Container(
                                                  //   height: 70,
                                                  //   width: 70,
                                                  //   child: ClipRRect(
                                                  //     borderRadius:
                                                  //         BorderRadius.circular(1000),
                                                  //     child: Image.asset(
                                                  //       "assets/image/purepng.png",
                                                  //       fit: BoxFit.fill,
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                  // SizedBox(width: 5),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        localization.text(
                                                                "address") +
                                                            " :",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width -
                                                            100,
                                                        child: Text(
                                                          "     ${item.city} , ${item.zone} , ${item.street} , ${item.build} , ${item.storey} ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
                                                          maxLines: 4,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
