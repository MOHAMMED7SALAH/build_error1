import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/Pages/notification/notificationPage.dart';
import 'package:saffi/ui/Pages/search/searchPage.dart';

Widget customSearchAppBar(BuildContext context) {
  return AppBar(
    elevation: 2,
    title: Text(
      "Cosmo Corner",
      style: boldStyle.copyWith(fontSize: 30, color: Colors.white),
    ),
    // Container(
    //   alignment: Alignment.centerLeft,
    //   padding: EdgeInsets.symmetric(horizontal: 5),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(100),
    //     color: Colors.white,
    //   ),
    //   child: Row(
    //     children: [
    //       Icon(
    //         Icons.star_border_outlined,
    //         color: primaryColor,
    //       ),
    //       SizedBox(width: 5),
    //       Text(
    //         "${Provider.of<UserController>(context, listen: true).userModel != null ? Provider.of<UserController>(context, listen: true).userModel.user.points : 0}",
    //         style: boldStyle.copyWith(color: primaryColor, fontSize: 10),
    //       ),
    //       SizedBox(width: 5),
    //       Icon(
    //         Icons.star_border_outlined,
    //         color: primaryColor,
    //       )
    //     ],
    //   ),
    // ),
    // Expanded(child: SizedBox())

    centerTitle: true,
    actions: [
      IconButton(
          icon: Icon(Icons.search),
          //  SvgPicture.asset("assets/svg/bell.svg"),
          onPressed: () => push(context, SearchPage())
          // push(context, NotifacationPage()),
          ),
      // IconButton(
      //     icon: Icon(Icons.notification_important),
      //     onPressed: () => push(context, NotifacationPage()))
    ],
    // bottom: PreferredSize(
    //   child: SearchBar(
    //     onChange: onSearch,
    //     onClose: onClose,
    //   ),
    //   preferredSize: Size.fromHeight(70.0),
    // ),
  );
}

/////////////////////////////////////////////
Widget customAppBar(BuildContext context, {bool withDrawer, String title}) {
  return AppBar(
    elevation: 2,
    title: title != null
        ? Text(
            title,
            style: boldStyle.copyWith(color: Colors.white),
          )
        : Text(
            "Cosmo Corner",
            style: boldStyle.copyWith(color: Colors.white),
          ),
    centerTitle: true,
    actions: [
      // IconButton(
      //     icon: Icon(Icons.notification_important),
      //     onPressed: () => push(context, NotifacationPage()))
    ],
    // leading: withDrawer == true
    //     ? IconButton(
    //         icon: Icon(Icons.format_align_center),
    //         onPressed: () => Scaffold.of(context).openDrawer(),
    //       )
    //     : null,
    // bottom: PreferredSize(
    //   child: SearchBar(),
    //   preferredSize: Size.fromHeight(70.0),
    // ),
  );
}
