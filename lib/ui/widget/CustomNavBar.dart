import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/style.dart';
import 'package:badges/badges.dart';

class AppBottomBar extends StatefulWidget {
  final Function onTap;

  const AppBottomBar({Key key, this.onTap}) : super(key: key);
  @override
  _AppBottomBarState createState() => _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  int inx = 0;
  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LangContoller>(context, listen: true);
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontSize: 10),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        currentIndex: inx,
        onTap: (index) {
          setState(() {
            inx = index;
          });
          widget.onTap(index);
        },
        items: [
          BottomNavigationBarItem(
            label: localization.text("home"),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageIcon(
                AssetImage("assets/icons/home (1).png"),
                size: 20,
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: localization.text("cart"),
            icon:
                //  Badge(
                //   badgeContent: Text('3'),
                //   child: Icon(Icons.settings),
                // )
                Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badge(
                badgeContent: Text(
                  "${Provider.of<UserController>(context, listen: true).userCart.length ?? 0}",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                position: BadgePosition(top: 5, end: 10),
                child: ImageIcon(
                  AssetImage(
                    "assets/icons/card.png",
                  ),
                  size: 20,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: localization.text("wishList"),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Badge(
                badgeContent: Text(
                  "${Provider.of<UserController>(context, listen: true).wishList.length ?? 0}",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
                position: BadgePosition(top: 5, end: 10),
                child: ImageIcon(
                  AssetImage("assets/icons/like.png"),
                  size: 20,
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            label: localization.text("profile"),
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ImageIcon(
                AssetImage("assets/icons/home.png"),
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
