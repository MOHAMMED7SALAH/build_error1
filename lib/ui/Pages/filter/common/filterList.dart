// import 'package:flutter/material.dart';
// import 'package:saffi/helper/style.dart';
// import 'package:saffi/ui/Pages/filter/filterPage.dart';

// class FilterList extends StatefulWidget {
//   final List items;

//   const FilterList(this.items);
//   @override
//   _FilterListState createState() => _FilterListState();
// }

// class _FilterListState extends State<FilterList> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.06,
//       child: ListView.builder(
//         itemCount: widget.items.length,
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               setState(() {
//                 for (int i = 0; i < branch.length; i++) {
//                   if (i == index) {
//                     branch[i].sel = true;
//                   } else {
//                     branch[i].sel = false;
//                   }
//                 }
//               });
//             },
//             child: Container(
//               alignment: Alignment.center,
//               padding: EdgeInsets.all(10),
//               margin: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 border: Border.all(
//                   color: widget.items[index].sel == true
//                       ? primaryColor
//                       : Colors.white,
//                 ),
//                 borderRadius: BorderRadius.circular(10),
//                 color: Colors.white,
//               ),
//               child: Text("${widget.items[index].title}"),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
