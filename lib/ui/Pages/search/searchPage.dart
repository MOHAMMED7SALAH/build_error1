import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/ui/Pages/home/MainPage.dart';
import 'package:saffi/ui/Pages/product/productDetilsPage.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'package:saffi/ui/widget/searchBar.dart';

import '../../widget/custom_alert.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainController>(context, listen: true);
    var lang = Provider.of<LangContoller>(context, listen: true);
    var userController = Provider.of<UserController>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          centerTitle: true,
          // leading: null,
          title: SearchBar(
            controller: searchController,
            onClose: () {
              setState(() {
                mainProvider.searchList = [];
                searchController.clear();
              });
            },
            onChange: (v) {
              Provider.of<MainController>(context, listen: false)
                  .searchOutput(context, search: v);
            },
          ),
        ),
        body: Center(
          child: mainProvider.loading == true
              ? Loading
              : mainProvider.searchList == []
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            child: Image.asset(
                              "assets/images/errorpage.png",
                              height: 150,
                              width: 150,
                              fit: BoxFit.fill,
                            ),
                          ),
                          SizedBox(height: 40),
                          Text(
                            localization.text("noProducts"),
                            style: boldStyle.copyWith(
                                color: primaryColor, fontSize: 20),
                          ),
                          SizedBox(height: 20),
                          Text(
                            localization.text("Pleasesearchforanyproduct"),
                            style: lightStyle,
                          ),
                          Text(
                            localization.text("othertryagain"),
                            style: lightStyle,
                          ),
                          SizedBox(height: 40),
                          CustomBtn(
                            title: localization.text("home"),
                            color: primaryColor,
                            width: MediaQuery.of(context).size.width / 2,
                            onPressed: removeUntil(context, MainPage()),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: mainProvider.searchList.length,
                      itemBuilder: (context, index) {
                        var item = mainProvider.searchList[index];
                        return InkWell(
                          onTap: () {
                            if (item.availability == Availability.EMPTY)
                              push(
                                  context,
                                  ProductDetilsPage(
                                    item: item,
                                  ));
                          },
                          child: Container(
                            height: 160,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  child: networkImage(
                                                    "${item.mainImg}",
                                                  )
                                                  // Image.asset(
                                                  //   "assets/images/prod.png",
                                                  //   fit: BoxFit.fill,
                                                  //   width: double.infinity,
                                                  //   height: double.infinity,
                                                  // ),
                                                  ),
                                              if (item.availability ==
                                                  Availability.AVAILABILITY)
                                                ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        color: Colors.black
                                                            .withOpacity(0.6),
                                                        child: Image.asset(
                                                            "assets/images/outstockar.png")))
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 8),
                                                Text(
                                                  "${item.name}",
                                                  maxLines: 1,
                                                ),
                                                SizedBox(height: 5),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "${item.category}",
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        userController
                                                            .wishListController(
                                                                context, item);
                                                      },
                                                      child: Container(
                                                        child: userController
                                                                .wishList
                                                                .any((element) =>
                                                                    element
                                                                        .id ==
                                                                    item.id)
                                                            ? SvgPicture.asset(
                                                                "assets/svg/fav.svg",
                                                                height: 25,
                                                              )
                                                            : Icon(
                                                                Icons.favorite,
                                                                color:
                                                                    accentColor,
                                                              ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  "ج.م ${item.price}",
                                                  style: lightStyle.copyWith(
                                                    color: Colors.red,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily: "braato",
                                                  ),
                                                ),
                                                SizedBox(height: 5),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: localization.text("lang") == "ar"
                                        ? Alignment.bottomLeft
                                        : Alignment.bottomRight,
                                    child: InkWell(
                                      onTap: () {
                                        if (item.availability ==
                                            Availability.EMPTY)
                                          CustomAlert()
                                              .addToCart(context, item: item);
                                      },
                                      child: Container(
                                        width: 170,
                                        height: 35,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          color: primaryColor,
                                          borderRadius: BorderRadius.only(
                                            bottomRight:
                                                localization.text("lang") ==
                                                        "ar"
                                                    ? Radius.circular(0)
                                                    : Radius.circular(15),
                                            bottomLeft:
                                                localization.text("lang") ==
                                                        "ar"
                                                    ? Radius.circular(15)
                                                    : Radius.circular(0),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.shopping_cart,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              localization.text("addToCart"),
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
