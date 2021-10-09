import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/Category/CategoryPage.dart';
import 'package:saffi/ui/Pages/auth/loginPage.dart';
import 'package:saffi/ui/Pages/search/searchPage.dart';
import 'package:saffi/ui/Pages/subCategoryPage.dart/subCategoryPage.dart';
import 'package:saffi/ui/widget/CustomSliderImage.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/networkImage.dart';
import 'common/productList.dart';

class ShopPage extends StatefulWidget {
  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool onSearch = false;

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    if (Provider.of<MainController>(context, listen: false)
        .categoriesList
        .isEmpty) {
      await Provider.of<MainController>(context, listen: false).init(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainController>(context, listen: true);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customSearchAppBar(
          context,
          // withDrawer: true,
          // onSearch: (v) {
          //   setState(() {
          //     onSearch = true;
          //   });
          //   Provider.of<MainController>(context, listen: false)
          //       .searchOutput(context, search: v);
          // },
        ),
        body: mainProvider.loading == true
            ? Loading
            : ListView(
                children: [
                  if (Provider.of<UserController>(context, listen: true)
                          .userModel ==
                      null)
                    Container(
                      height: 50,
                      color: accentColor,
                      child: FlatButton(
                        child: Text(
                          localization.text("loginOrRegister"),
                          style: boldStyle.copyWith(color: Colors.white),
                        ),
                        onPressed: () => push(context, LoginPage()),
                      ),
                    ),
                  if (mainProvider.categoriesList != null ||
                      mainProvider.categoriesList.isNotEmpty)
                    Container(
                      height: 120,
                      width: double.infinity,
                      child: ListView.builder(
                        itemCount: mainProvider.categoriesList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = mainProvider.categoriesList[index];
                          return InkWell(
                            onTap: () => push(
                                context,
                                SubCategoryPage(
                                  // categoriesModel: item,
                                  title: item.name,
                                  id: item.id,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    // height: 50,
                                    // width: 50,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 3,
                                          color: primaryColor,
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1000),
                                      child: networkImage(
                                        "${item.img}",
                                        width: 60,
                                        height: 60,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "${item.name}",
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  if (mainProvider.sliderList != null ||
                      mainProvider.sliderList.isNotEmpty)
                    CustomSliderImage(
                      height: 150,
                      sliderList: mainProvider.sliderList,
                    ),
                  // ProductList(
                  //   "Popular Product",
                  //   mainProvider.productsList,
                  // ),
                  // SizedBox(height: 10),
                  if (mainProvider.featuredProducts.isNotEmpty)
                    ProductList(
                      localization.text("dealOFDay"),
                      mainProvider.featuredProducts,
                    ),
                  SizedBox(height: 10),
                  if (mainProvider.sliderList != null ||
                      mainProvider.sliderList.isNotEmpty)
                    CustomSliderImage(
                      height: MediaQuery.of(context).size.height * 0.2,
                      sliderList: mainProvider.sliderList,
                    ),
                  SizedBox(height: 10),
                  if (mainProvider.productsPointList.isNotEmpty)
                    ProductList(
                      localization.text("productsWithPoints"),
                      mainProvider.productsPointList,
                    ),
                ],
              ),
      ),
    );
  }
}
