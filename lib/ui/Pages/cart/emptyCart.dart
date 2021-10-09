import 'package:flutter/cupertino.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/style.dart';

class EmptyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/emptycart.png"),
          SizedBox(height: 20),
          Text(localization.text("Cartisempty")),
          SizedBox(height: 20),
          Text(
            localization.text("yourcartisemptyyoucandoshoppingnow"),
            style: lightStyle,
          ),
        ],
      ),
    );
  }
}
