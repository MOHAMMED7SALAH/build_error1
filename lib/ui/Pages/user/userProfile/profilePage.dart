import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/auth/loginPage.dart';
import 'package:saffi/ui/Pages/intro/splash_screen.dart';
import 'package:saffi/ui/Pages/user/address/addressUser.dart';
import 'package:saffi/ui/Pages/user/editUser.dart/EditUserPage.dart';
import 'package:saffi/ui/Pages/user/orders/myOrdersPage.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/header.dart';
import 'package:url_launcher/url_launcher.dart';
import '../common/listTileProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var lang = Provider.of<LangContoller>(context, listen: true);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: double.infinity,
            child: Stack(
              children: [
                Header(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: double.infinity,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(1000),
                          child: Image.asset(
                            "assets/images/3.png",
                            height: double.infinity,
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${Provider.of<UserController>(context, listen: true).userModel != null ? Provider.of<UserController>(context, listen: true).userModel.user.name : localization.text("guest")}",
                        style: boldStyle,
                      )
                    ],
                  ),
                ),
                if (Provider.of<UserController>(context, listen: true)
                        .userModel !=
                    null)
                  SafeArea(
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            localization.text("userId") +
                                " : ${Provider.of<UserController>(context, listen: true).userModel.user.id}",
                            style: boldStyle.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          Text(
                            localization.text("yourPoints") +
                                " : ${Provider.of<UserController>(context, listen: true).userModel.user.points}",
                            style: boldStyle.copyWith(color: Colors.white),
                          ),
                          SizedBox(height: 5),
                          SizedBox(height: 5),
                          SizedBox(height: 5),
                        ],
                      ),
                    ),
                  ),
                if (Provider.of<UserController>(context, listen: true)
                        .userModel ==
                    null)
                  SafeArea(
                      child: FlatButton(
                    child: Text(
                      localization.text("login"),
                      style: boldStyle.copyWith(color: Colors.white),
                    ),
                    onPressed: () => push(context, LoginPage()),
                  ))
              ],
            ),
          ),
          SizedBox(height: 50),

          if (Provider.of<UserController>(context, listen: true).userModel !=
              null)
            ListTileProfile(
              onTap: () => push(context, EditUsarPage()),
              iconPath: "assets/svg/user.svg",
              title: localization.text("editProfile"),
            ),
          if (Provider.of<UserController>(context, listen: true).userModel !=
              null)
            ListTileProfile(
              icon: Icons.add_moderator,
              title: localization.text("MyOrders"),
              color: Color(0xFF3368FF),
              onTap: () => push(context, MyOrderPage()),
            ),
          if (Provider.of<UserController>(context, listen: true).userModel !=
              null)
            ListTileProfile(
              iconPath: "assets/svg/address.svg",
              title: localization.text("MyAddress"),
              color: Color(0xFFF65D2D),
              onTap: () => push(
                  context,
                  MyAddressPage(
                    type: null,
                    id: null,
                  )),
            ),
          ListTileProfile(
              iconPath: "assets/svg/whats_app.svg",
              title: localization.text("whatsApp"),
              color: Color(0xFFF65D2D),
              onTap: () async {
                await launch(
                  "https://wa.me/+201117952435",
                );
              }),
          // ListTileProfile(
          //   iconPath: "assets/svg/mobile-store.svg",
          //   title: "My Cart",
          //   color: Color(0xFF2B1C54),
          // ),

          ListTileProfile(
            icon: Icons.language,
            title: localization.text("Changelanguage"),
            color: Color(0xFF2DF65C),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
                      CustomBtn(
                        title: "العربية",
                        onPressed: () async {
                          await localization.setNewLanguage("ar", true);
                          removeUntil(context, SplashScreen());
                        },
                      ),
                      SizedBox(height: 10),
                      CustomBtn(
                        title: "English",
                        onPressed: () async {
                          await localization.setNewLanguage("en", true);
                          removeUntil(context, SplashScreen());
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              );
            },
          ),
          // ListTileProfile(
          //   iconPath: "assets/svg/heart.svg",
          //   title: "Wishlist",
          //   color: Color(0xFF622DF6),
          // ),
          ListTileProfile(
            // iconPath: "assets/svg/heart.svg",
            icon: Icons.priority_high,
            title: localization.text("AboutUS"),
            color: Color(0xFFF62D56),
          ),
          ListTileProfile(
            // iconPath: "assets/svg/heart.svg",
            icon: Icons.star_border_outlined,
            title: localization.text("RateApp"),
            color: Color(0xFFE8E34E),
          ),
          if (Provider.of<UserController>(context, listen: true).userModel !=
              null)
            ListTileProfile(
              // iconPath: "assets/svg/heart.svg",
              onTap: () => Provider.of<UserController>(context, listen: false)
                  .logout(context),
              icon: Icons.logout,
              title: localization.text("Logout"),
              color: Color(0xFF622DF6),
            ),
          SizedBox(height: 70)
        ],
      ),
    );
  }
}
