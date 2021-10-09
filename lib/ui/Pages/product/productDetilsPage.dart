import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/ui/Pages/product/allProducts.dart';
import 'package:saffi/ui/Pages/reate/allReate.dart';
import 'package:saffi/ui/Pages/user/address/addressUser.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomReateStar.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'package:saffi/ui/widget/productCard.dart';
import 'package:saffi/ui/widget/sliderWidget.dart';

import '../../../helper/style.dart';
import '../../../helper/style.dart';
import '../../widget/custom_alert.dart';

class ProductDetilsPage extends StatefulWidget {
  final ProductDatum item;

  const ProductDetilsPage({Key key, this.item}) : super(key: key);
  @override
  _ProductDetilsPageState createState() => _ProductDetilsPageState();
}

class _ProductDetilsPageState extends State<ProductDetilsPage> {
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false)
        .simillerProducts(context, widget.item.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LangContoller>(context, listen: true);
    var userController = Provider.of<UserController>(context, listen: true);
    var mianController = Provider.of<MainController>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.38,
              child: Stack(
                children: [
                  SliderWidget(
                      images: List.generate(
                    widget.item.additionalImages.length,
                    (index) {
                      return networkImage(
                          "${widget.item.additionalImages[index]}");
                    },
                  )

                      // networkImage("${widget.item.mainImg}"),
                      // networkImage("${widget.item.mainImg}"),
                      // Image.asset(
                      //   "assets/images/prod.png",
                      //   fit: BoxFit.fill,
                      // ),
                      // Image.asset(
                      //   "assets/images/prod.png",
                      //   fit: BoxFit.fill,
                      // ),
                      // ],
                      ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SafeArea(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  if (widget.item.dicount != null)
                    Align(
                      alignment: Alignment.topRight,
                      child: SafeArea(
                        child: Container(
                          width: 50,
                          height: 30,
                          margin: EdgeInsets.only(top: 10),
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.6),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(12),
                                    bottomLeft: Radius.circular(12))),
                            child: Text(
                              "${widget.item.dicount} %",
                              style: boldStyle.copyWith(
                                  color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.item.category}",
                    style: lightStyle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${widget.item.name}",
                    style: boldStyle,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      CustomReateBar(
                        rate: widget.item.rate,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      FlatButton(
                        onPressed: () => push(
                            context,
                            AllRatePage(
                              id: widget.item.id,
                              rate: widget.item.rate,
                            )),
                        child: Text(
                          localization.text("seeReview"),
                          style: lightStyle.copyWith(color: accentColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Container(
                  //   height: 35,
                  //   child: ListView.builder(
                  //     scrollDirection: Axis.horizontal,
                  //     physics: ScrollPhysics(),
                  //     reverse: true,
                  //     itemCount: selectColor.length,
                  //     shrinkWrap: true,
                  //     itemBuilder: (c, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.only(right: 8.0),
                  //         child: Container(
                  //           height: 35,
                  //           width: 35,
                  //           decoration: BoxDecoration(
                  //             color: selectColor[index].color,
                  //             borderRadius: BorderRadius.circular(10000),
                  //           ),
                  //           child: InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 for (int i = 0; i < selectColor.length; i++) {
                  //                   if (i != index) {
                  //                     selectColor[i].sel = false;
                  //                   } else {
                  //                     selectColor[index].sel = true;
                  //                   }
                  //                 }
                  //               });
                  //             },
                  //             child: Visibility(
                  //               visible: selectColor[index].sel ?? false,
                  //               child: Center(
                  //                 child: Icon(
                  //                   Icons.check,
                  //                   color: Colors.white,
                  //                   size: 18,
                  //                 ),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  // SizedBox(height: 10),
                  Row(
                    children: [
                      widget.item.dicount == null
                          ? AutoSizeText(
                              "${widget.item.price} ج.م",
                              style: lightStyle.copyWith(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontFamily: "braato",
                              ),
                            )
                          : Row(
                              children: [
                                AutoSizeText(
                                  "${((100 - double.parse(widget.item.dicount)) / 100 * double.parse(widget.item.price)).toStringAsFixed(2)} ج.م",
                                  style: lightStyle.copyWith(
                                    color: Colors.red,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "braato",
                                  ),
                                ),
                                SizedBox(width: 10),
                                AutoSizeText(
                                  "${widget.item.price} ج.م",
                                  style: lightStyle.copyWith(
                                    color: Colors.red,
                                    decoration: TextDecoration.lineThrough,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "braato",
                                  ),
                                ),
                              ],
                            ),
                      if (widget.item.points != "0")
                        Text(
                          localization.text("or") + " ",
                          style: lightStyle.copyWith(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontFamily: "braato",
                          ),
                        ),
                      if (widget.item.points != "0")
                        Text(
                          "${widget.item.points} " + localization.text("point"),
                          style: lightStyle.copyWith(
                            color: Colors.green,
                            fontStyle: FontStyle.italic,
                            fontFamily: "braato",
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   "Boot size",
                  //   style: lightStyle.copyWith(fontSize: 20),
                  // ),
                  SizedBox(height: 10),
                  // CustomDropMenuo(
                  //   height: 50,
                  //   items: [
                  //     "40",
                  //     "41",
                  //     "43",
                  //     "44",
                  //     "45",
                  //   ],
                  //   item: "40",
                  //   onChanged: (v) {},
                  //   width: 150,
                  // ),
                  // SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomBtn(
                          title: localization.text("addToCart"),
                          color: primaryColor,
                          onPressed: () {
                            CustomAlert().addToCart(context, item: widget.item);
                          },
                          textColor: Colors.white,
                        ),
                      ),
                      if (widget.item.points != "0") SizedBox(width: 10),
                      if (widget.item.points != "0")
                        Expanded(
                          child: CustomBtn(
                            title: localization.text("byWithPoints"),
                            color: Colors.green,
                            onPressed: () => push(
                                context,
                                MyAddressPage(
                                  type: 1,
                                  chckout: true,
                                  id: widget.item.id,
                                )),
                            textColor: Colors.white,
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CustomBtn(
                    title: localization.text("addtoWishList"),
                    textColor: userController.wishList
                            .any((element) => element.id == widget.item.id)
                        ? Colors.white
                        : primaryColor,
                    borderColor: userController.wishList
                            .any((element) => element.id == widget.item.id)
                        ? accentColor
                        : primaryColor,
                    onPressed: () {
                      setState(() {
                        userController.wishListController(context, widget.item);
                      });
                    },
                    color: userController.wishList
                            .any((element) => element.id == widget.item.id)
                        ? accentColor
                        : Color(0x00000000),
                  ),
                  SizedBox(height: 20),
                  Text(localization.text("detils")),
                  SizedBox(height: 10),
                  Html(data: widget.item.description),
                  // Text("* ${widget.item.description}", style: lightStyle),
                  // Text("* Boot size : 41", style: lightStyle),
                  // Text("* Boot size : 41", style: lightStyle),
                  // Text("* Boot size : 41", style: lightStyle),
                  SizedBox(height: 20),
                  mianController.loading == true
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Loading,
                        )
                      : mianController.similerProducts == null ||
                              mianController.similerProducts.isEmpty
                          ? SizedBox()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(localization.text("RELATEDPRODUCT")),
                                    InkWell(
                                      onTap: () => push(
                                          context,
                                          AllProductsPage(
                                            productsList:
                                                mianController.similerProducts,
                                          )),
                                      child: Text(
                                        localization.text("seeAll"),
                                        style: lightStyle.copyWith(
                                            color: accentColor, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
              padding: EdgeInsets.symmetric(horizontal: 10),
              children: List.generate(
                mianController.similerProducts.length < 6
                    ? mianController.similerProducts.length
                    : 6,
                (index) {
                  return ProductCard(
                    item: mianController.similerProducts[index],
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

List<Coloor> selectColor = [
  Coloor(color: Color(0xFFDE4D0D), sel: true),
  Coloor(color: Color(0xFF3D0DDE), sel: false),
  Coloor(color: Color(0xFFB8B8B8), sel: false),
  Coloor(color: Color(0xFF191919), sel: false),
];

class Coloor {
  bool sel;
  Color color;
  Coloor({this.color, this.sel});
}
