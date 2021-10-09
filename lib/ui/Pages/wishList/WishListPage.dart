import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/productCard.dart';

class WishListPage extends StatefulWidget {
  @override
  _WishListPageState createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserController>(context, listen: true);
    return Scaffold(
      appBar: customAppBar(context, title: "WishList"),
      body: userProvider.wishList.isEmpty
          ? Center(child: Image.asset("assets/images/errorpage.png"))
          : GridView.count(
              padding: EdgeInsets.all(15),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.2,
              children: List.generate(
                userProvider.wishList.length,
                (index) {
                  return ProductCard(
                    item: userProvider.wishList[index],
                  );
                },
              ),
            ),
    );
  }
}
