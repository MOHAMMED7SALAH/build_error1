import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/model/productsModel.dart';
import 'package:saffi/ui/widget/productCard.dart';

class ProductList extends StatelessWidget {
  final String title;
  final List<ProductDatum> productsList;

  const ProductList(this.title, this.productsList);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: boldStyle,
              ),
              Divider(
                color: primaryColor,
                height: 10,
                thickness: 3,
                endIndent: MediaQuery.of(context).size.width - 100,
              ),
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            itemCount: productsList.length < 10 ? productsList.length : 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ProductCard(
                item: productsList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
