// import 'package:flutter/material.dart';
// import 'package:saffi/helper/style.dart';

// class CustomDrawer extends StatefulWidget {
//   @override
//   _CustomDrawerState createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Drawer(
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.only(top: h * 0.06),
//             height: MediaQuery.of(context).size.height * 0.3,
//             width: double.infinity,
//             color: primaryColor,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 3,
//                     ),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(1000),
//                     child: Image.asset(
//                       "assets/images/3.jpg",
//                       height: double.infinity,
//                       fit: BoxFit.fill,
//                       width: double.infinity,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   "عبدالله اسامة",
//                   style: TextStyle(color: Colors.white),
//                 ),
//                 Text(
//                   "ao25332@gmail.com",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//               child: ListView(
//             padding: EdgeInsets.all(10),
//             children: [
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/home.svg',
//               //   ),
//               //   onTap: () {},
//               //   title: "الرئيسية",
//               // ),
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/fav_off.svg',
//               //   ),
//               //   onTap: () => push(context, FavPage()),
//               //   title: "المفضله",
//               // ),
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/review.svg',
//               //   ),
//               //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (context) => AllReviewsPage(),
//               //   )),
//               //   title: "المراجعات",
//               // ),
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/rate.svg',
//               //   ),
//               //   onTap: () {},
//               //   title: "قيم التطبيق",
//               // ),
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/call.svg',
//               //   ),
//               //   onTap: () => push(context, ContactusPage()),
//               //   title: "اتصل بنا",
//               // ),
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/info.svg',
//               //   ),
//               //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
//               //     builder: (context) => AboutusPage(),
//               //   )),
//               //   title: "عن مكتبة المشرق",
//               // ),
//               // drawerListTile(
//               //   icon: buildLocalImage(
//               //     'assets/svg/logout.svg',
//               //   ),
//               //   onTap: () {},
//               //   title: "تسجيل الخروج",
//               // ),
//             ],
//           ))
//         ],
//       ),
//     );
//   }
// }
