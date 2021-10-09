import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/ui/Pages/product/allProducts.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/productCard.dart';
import 'package:shimmer/shimmer.dart';

class SubCategoryPage extends StatefulWidget {
  final String title;
  final String id;
  const SubCategoryPage({Key key, @required this.title, @required this.id})
      : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false)
        .getSubCategory(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: customAppBar(context, title: widget.title),
          body: Consumer<MainController>(
            builder: (context, value, child) {
              return value.loadingSubCat == true
                  ? Loading
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      itemCount: value.subCategory.length,
                      itemBuilder: (context, i) {
                        return Column(
                          // padding: EdgeInsets.symmetric(vertical: 16),
                          // shrinkWrap: true,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "${value.subCategory[i].name}",
                                    style: boldStyle.copyWith(fontSize: 16),
                                  ),
                                  GestureDetector(
                                    onTap: () => push(
                                        context,
                                        AllProductsPage(
                                          id: value.subCategory[i].id,
                                        )),
                                    child: Text(
                                      "عرض المزيد",
                                      style: boldStyle.copyWith(
                                          fontSize: 14, color: primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                child: FutureBuilder(
                                  future: value.getProducts(
                                      context, value.subCategory[i].id),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey[300],
                                            highlightColor: Colors.white,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    } else if (snapshot.hasData &&
                                        snapshot.data.data != null) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            snapshot.data.data.length > 10
                                                ? 10
                                                : snapshot.data.data.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return ProductCard(
                                              item: snapshot.data.data[index]);
                                        },
                                      );
                                    } else {
                                      return Center(
                                        child: Text(
                                          "لا يوجد منتجات الان في هذا القسم",
                                          style:
                                              boldStyle.copyWith(fontSize: 14),
                                        ),
                                      );
                                    }
                                  },
                                ))
                          ],
                        );
                      },
                    );
            },
          )),
    );
  }
}
