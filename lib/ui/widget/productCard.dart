import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/ui/Pages/product/productDetilsPage.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'package:shimmer/shimmer.dart';

import 'custom_alert.dart';

class ProductCard extends StatefulWidget {
  final ProductDatum item;

  const ProductCard({this.item});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var userController = Provider.of<UserController>(context, listen: true);
    var lang = Provider.of<LangContoller>(context, listen: true);
    return InkWell(
      onTap: () {
        if (widget.item.availability == Availability.EMPTY)
          push(
            context,
            ProductDetilsPage(item: widget.item),
          );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: networkImage("${widget.item.mainImg}")),
                          if (widget.item.availability ==
                              Availability.AVAILABILITY)
                            ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                                child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.black.withOpacity(0.6),
                                    child: Image.asset(
                                        "assets/images/outstockar.png")))
                        ],
                      )
                      // Image.asset(
                      //   "assets/images/prod.png",
                      //   fit: BoxFit.fill,
                      //   width: double.infinity,
                      // ),
                      ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "${widget.item.category ?? ""}",
                          style: lightStyle,
                        ),
                        SizedBox(height: 3),
                        AutoSizeText(
                          "${widget.item.name}",
                          maxLines: 1,
                        ),
                        SizedBox(height: 3),
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
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: "braato",
                                        ),
                                      ),
                                    ],
                                  ),
                            if (widget.item.points != "0")
                              AutoSizeText(
                                localization.text("or") + " ",
                                style: lightStyle.copyWith(
                                  color: Colors.black,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "braato",
                                ),
                              ),
                            if (widget.item.points != "0")
                              AutoSizeText(
                                "${widget.item.points} Points",
                                style: lightStyle.copyWith(
                                  color: Colors.green,
                                  fontStyle: FontStyle.italic,
                                  fontFamily: "braato",
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (widget.item.availability == Availability.EMPTY)
                        CustomAlert().addToCart(context, item: widget.item);
                      // Provider.of<UserController>(context, listen: false)
                      //     .addToCart(
                      //   context,
                      //   item: widget.item,
                      // );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        // userController.userCart
                        //         .any((e) => e.productId == widget.item.id)
                        //     ? "Remove from Cart"
                        //     :
                        localization.text("addToCart"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 50,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          userController.wishListController(
                              context, widget.item);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            margin: EdgeInsets.all(5),
                            child: Icon(
                              userController.wishList.any(
                                      (element) => element.id == widget.item.id)
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              size: 18,
                              color: Colors.red,
                            )
                            // SvgPicture.asset(
                            //   "assets/svg/fav.svg",
                            //   height: 25,
                            // ),
                            ),
                      ),
                      if (widget.item.dicount != null)
                        Container(
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
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoadingProductCart extends StatelessWidget {
  const LoadingProductCart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.white,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.3,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: networkImage(
                                  "https://pic-hd.com/wp-content/uploads/2018/03/%D8%B5%D9%88%D8%B1-%D8%B9%D9%86-%D8%A7%D9%84%D8%B1%D8%AD%D9%8A%D9%84_16-564x600.jpg")),
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.black.withOpacity(0.6),
                                  child: Image.asset(
                                      "assets/images/outstockar.png")))
                        ],
                      )
                      // Image.asset(
                      //   "assets/images/prod.png",
                      //   fit: BoxFit.fill,
                      //   width: double.infinity,
                      // ),
                      ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "جاري التحميل",
                          style: lightStyle,
                        ),
                        SizedBox(height: 3),
                        AutoSizeText(
                          "جاري التحميل",
                          maxLines: 1,
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            // widget.item.dicount == null
                            //     ?
                            AutoSizeText(
                              "جاري التحميل ج.م",
                              style: lightStyle.copyWith(
                                color: Colors.red,
                                fontStyle: FontStyle.italic,
                                fontFamily: "braato",
                              ),
                            )
                            // : Row(
                            //     children: [
                            //       AutoSizeText(
                            //         "${((100 - double.parse(widget.item.dicount)) / 100 * double.parse(widget.item.price)).toStringAsFixed(2)} ج.م",
                            //         style: lightStyle.copyWith(
                            //           color: Colors.red,
                            //           fontStyle: FontStyle.italic,
                            //           fontFamily: "braato",
                            //         ),
                            //       ),
                            //       SizedBox(width: 10),
                            //       AutoSizeText(
                            //         "${widget.item.price} ج.م",
                            //         style: lightStyle.copyWith(
                            //           color: Colors.red,
                            //           decoration: TextDecoration.lineThrough,
                            //           fontStyle: FontStyle.italic,
                            //           fontFamily: "braato",
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // if (widget.item.points != "0")
                            ,
                            AutoSizeText(
                              localization.text("or") + " ",
                              style: lightStyle.copyWith(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontFamily: "braato",
                              ),
                            ),

                            AutoSizeText(
                              "جاري التحميل",
                              style: lightStyle.copyWith(
                                color: Colors.green,
                                fontStyle: FontStyle.italic,
                                fontFamily: "braato",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Text(
                      // userController.userCart
                      //         .any((e) => e.productId == widget.item.id)
                      //     ? "Remove from Cart"
                      //     :
                      localization.text("addToCart"),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
