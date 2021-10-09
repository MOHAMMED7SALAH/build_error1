import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/categorisModel.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'package:saffi/ui/widget/productCard.dart';

import '../../widget/customSearchAppBar.dart';

class CategoryPage extends StatefulWidget {
  final CategoriesModel categoriesModel;

  const CategoryPage({Key key, this.categoriesModel}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool grid = true;
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false)
        .getProducts(context, widget.categoriesModel.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainController>(context, listen: true);
    var userController = Provider.of<UserController>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(context),
        body: mainProvider.loading == true
            ? Loading
            : mainProvider.productsList.isEmpty
                ? Center(child: Image.asset("assets/images/errorpage.png"))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              localization.text("product"),
                              style: boldStyle,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/filter2.svg",
                                  height: 18,
                                ),
                                SizedBox(width: 15),
                                InkWell(
                                  child: Container(
                                    child: SvgPicture.asset(
                                      "assets/svg/grid.svg",
                                      height: 25,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      grid = !grid;
                                      print("object");
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      grid == true
                          ? Expanded(
                              child: GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.2,
                                children: List.generate(
                                  mainProvider.productsList.length,
                                  (index) {
                                    return ProductCard(
                                      item: mainProvider.productsList[index],
                                    );
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.all(5),
                                itemCount: mainProvider.productsList.length,
                                itemBuilder: (context, index) {
                                  var item = mainProvider.productsList[index];
                                  return Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.17,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: ClipRRect(
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
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                              item.category,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                            SvgPicture.asset(
                                                              "assets/svg/fav.svg",
                                                              height: 25,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 5),
                                                        Text(
                                                          "ج.م ${item.price}",
                                                          style: lightStyle
                                                              .copyWith(
                                                            color: Colors.red,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                            fontFamily:
                                                                "braato",
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
                                            alignment:
                                                localization.text("lang") ==
                                                        "ar"
                                                    ? Alignment.bottomLeft
                                                    : Alignment.bottomRight,
                                            child: Container(
                                              width: 170,
                                              height: 35,
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 5),
                                              decoration: BoxDecoration(
                                                color: primaryColor,
                                                borderRadius: localization
                                                            .text("lang") ==
                                                        "ar"
                                                    ? BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(15),
                                                      )
                                                    : BorderRadius.only(
                                                        bottomRight:
                                                            Radius.circular(15),
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
                                                    // userController.userCart.any((e) =>
                                                    //         e.productId == item.id)
                                                    //     ? "Remove from Cart"
                                                    //     :
                                                    localization
                                                        .text("addToCart"),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            ),
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
