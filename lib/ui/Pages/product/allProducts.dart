import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'package:saffi/ui/widget/productCard.dart';
import 'package:shimmer/shimmer.dart';

class AllProductsPage extends StatefulWidget {
  final List<ProductDatum> productsList;
  final String id;
  const AllProductsPage({Key key, this.productsList, this.id})
      : super(key: key);
  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  // bool grid = true;
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false)
        .getProducts(context, widget.id);
    super.initState();
  }

  ProductsModel items;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Products",
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
                        // setState(() {
                        //   grid = !grid;
                        //   print("objecthhhhhhhhhhhhhhhh");
                        // });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: widget.productsList != null
                  ? GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.2,
                      children: List.generate(
                        widget.productsList.length,
                        (index) {
                          return ProductCard(
                            item: widget.productsList[index],
                          );
                        },
                      ),
                    )
                  : Consumer<MainController>(
                      builder: (context, value, child) {
                        return FutureBuilder(
                          future: value.getProducts(context, widget.id),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.2,
                                children: List.generate(
                                  12,
                                  (index) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[300],
                                      highlightColor: Colors.white,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                      ),
                                    );
                                    // ProductCard(
                                    //   item: Provider.of<MainController>(context,
                                    //           listen: true)
                                    //       .productsList[index],
                                    // );
                                  },
                                ),
                              );
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   itemCount: 5,
                              //   scrollDirection: Axis.horizontal,
                              //   itemBuilder: (context, index) {
                              //     return Shimmer.fromColors(
                              //       baseColor: Colors.grey[300],
                              //       highlightColor: Colors.white,
                              //       child: Container(
                              //         margin: EdgeInsets.symmetric(horizontal: 5),
                              //         width: MediaQuery.of(context).size.width / 2.5,
                              //         decoration: BoxDecoration(
                              //           color: Colors.grey[300],
                              //           borderRadius: BorderRadius.circular(15.0),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              // );
                            } else if (snapshot.hasData &&
                                snapshot.data.data != null) {
                              items = snapshot.data;
                              return GridView.count(
                                crossAxisCount: 2,
                                childAspectRatio: 1 / 1.2,
                                children: List.generate(
                                  items.data.length,
                                  (index) {
                                    return
                                        // Shimmer.fromColors(
                                        //   baseColor: Colors.grey[300],
                                        //   highlightColor: Colors.white,
                                        //   child: Container(
                                        //     margin: EdgeInsets.symmetric(horizontal: 5),
                                        //     width: MediaQuery.of(context).size.width / 2.5,
                                        //     decoration: BoxDecoration(
                                        //       color: Colors.grey[300],
                                        //       borderRadius: BorderRadius.circular(15.0),
                                        //     ),
                                        //   ),
                                        // );
                                        ProductCard(
                                      item: Provider.of<MainController>(context,
                                              listen: true)
                                          .productsList[index],
                                    );
                                  },
                                ),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  "لا يوجد منتجات الان في هذا القسم",
                                  style: boldStyle.copyWith(fontSize: 14),
                                ),
                              );
                            }
                          },
                        );
                      },
                    )

              // GridView.count(
              //   crossAxisCount: 2,
              //   childAspectRatio: 1 / 1.2,
              //   children: List.generate(
              //     Provider.of<MainController>(context, listen: true)
              //         .productsList
              //         .length,
              //     (index) {
              //       return ProductCard(
              //         item: Provider.of<MainController>(context, listen: true)
              //             .productsList[index],
              //       );
              //     },
              //   ),
              // ),
              )
          // grid == true
          //     ?
          //     : Expanded(
          //   child: ListView.builder(
          //     padding: EdgeInsets.all(5),
          //     itemCount: widget.productsList.length,
          //     itemBuilder: (context, index) {
          //       var item = widget.productsList[index];
          //       return Container(
          //         height: MediaQuery.of(context).size.height * 0.17,
          //         child: Card(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(15.0),
          //           ),
          //           child: Stack(
          //             children: [
          //               Padding(
          //                 padding: EdgeInsets.all(10),
          //                 child: Row(
          //                   children: [
          //                     Expanded(
          //                       flex: 3,
          //                       child: ClipRRect(
          //                           borderRadius:
          //                               BorderRadius.circular(15.0),
          //                           child: networkImage(
          //                             "${item.mainImg}",
          //                           )
          //                           // Image.asset(
          //                           //   "assets/images/prod.png",
          //                           //   fit: BoxFit.fill,
          //                           //   width: double.infinity,
          //                           //   height: double.infinity,
          //                           // ),
          //                           ),
          //                     ),
          //                     Expanded(
          //                       flex: 4,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Column(
          //                           crossAxisAlignment:
          //                               CrossAxisAlignment.start,
          //                           children: [
          //                             SizedBox(height: 8),
          //                             Text(
          //                               "${item.name}",
          //                               maxLines: 1,
          //                             ),
          //                             SizedBox(height: 5),
          //                             Row(
          //                               mainAxisAlignment:
          //                                   MainAxisAlignment
          //                                       .spaceBetween,
          //                               children: [
          //                                 SvgPicture.asset(
          //                                   "assets/svg/fav.svg",
          //                                   height: 25,
          //                                 ),
          //                               ],
          //                             ),
          //                             SizedBox(height: 5),
          //                             Text(
          //                               "ج.م ${item.price}",
          //                               style: lightStyle.copyWith(
          //                                 color: Colors.red,
          //                                 fontStyle: FontStyle.italic,
          //                                 fontFamily: "braato",
          //                               ),
          //                             ),
          //                             SizedBox(height: 5),
          //                           ],
          //                         ),
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               Align(
          //                 alignment: Alignment.bottomRight,
          //                 child: Container(
          //                   width: 170,
          //                   height: 35,
          //                   alignment: Alignment.center,
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal: 5, vertical: 5),
          //                   decoration: BoxDecoration(
          //                     color: primaryColor,
          //                     borderRadius: BorderRadius.only(
          //                       bottomRight: Radius.circular(15),
          //                     ),
          //                   ),
          //                   child: Row(
          //                     mainAxisSize: MainAxisSize.min,
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Icon(
          //                         Icons.shopping_cart,
          //                         color: Colors.white,
          //                       ),
          //                       SizedBox(width: 5),
          //                       Text(
          //                         // userController.userCart.any((e) =>
          //                         //         e.productId == item.id)
          //                         //     ? "Remove from Cart"
          //                         //     :
          //                         "ADD TO CART",
          //                         style: TextStyle(color: Colors.white),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               )
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
