// import 'package:flutter/material.dart';
// import 'package:saffi/helper/style.dart';
// import 'package:saffi/ui/Pages/filter/common/filterList.dart';
// import 'package:saffi/ui/widget/CustomBtn.dart';
// import 'package:saffi/ui/widget/CustomdropMenu.dart';
// import 'package:saffi/ui/widget/customSearchAppBar.dart';
// import 'package:flutter_range_slider/flutter_range_slider.dart' as rg;

// import 'common/flilterColor.dart';

// class FilterPage extends StatefulWidget {
//   @override
//   _FilterPageState createState() => _FilterPageState();
// }

// class _FilterPageState extends State<FilterPage> {
//   double minPrice = 0;
//   double maxPrice = 100;
//   double _lowerValue = 0;
//   double _upperValue = 100;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(context),
//       body: ListView(
//         padding: EdgeInsets.all(15),
//         children: [
//           Text(
//             "Brands",
//             style: boldStyle,
//           ),
//           Divider(
//             color: primaryColor,
//             height: 5,
//             thickness: 3,
//             endIndent: MediaQuery.of(context).size.width - 100,
//           ),
//           SizedBox(height: 20),
//           FilterList(branch),
//           SizedBox(height: 30),
//           Text(
//             "Target Group",
//             style: boldStyle,
//           ),
//           Divider(
//             color: primaryColor,
//             height: 5,
//             thickness: 3,
//             endIndent: MediaQuery.of(context).size.width - 100,
//           ),
//           SizedBox(height: 20),
//           FilterList(target),
//           SizedBox(height: 40),
//           Text(
//             "Product Size",
//             style: boldStyle,
//           ),
//           Divider(
//             color: primaryColor,
//             height: 5,
//             thickness: 3,
//             endIndent: MediaQuery.of(context).size.width - 100,
//           ),
//           SizedBox(height: 20),
//           CustomDropMenuo(
//             height: 50,
//             items: [
//               "40",
//               "41",
//               "42",
//               "43",
//               "44",
//               "45",
//             ],
//             item: "40",
//             onChanged: (v) {},
//             width: MediaQuery.of(context).size.width - 100,
//           ),
//           SizedBox(height: 40),
//           Text(
//             "Color",
//             style: boldStyle,
//           ),
//           Divider(
//             color: primaryColor,
//             height: 5,
//             thickness: 3,
//             endIndent: MediaQuery.of(context).size.width - 80,
//           ),
//           SizedBox(height: 20),
//           FilterColor(),
//           SizedBox(height: 40),
//           Text(
//             "Price",
//             style: boldStyle,
//           ),
//           Divider(
//             color: primaryColor,
//             height: 5,
//             thickness: 3,
//             endIndent: MediaQuery.of(context).size.width - 80,
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text("$_lowerValue ج.م"),
//               Expanded(
//                 child: SliderTheme(
//                   data: SliderTheme.of(context).copyWith(
//                     activeTrackColor: Theme.of(context).primaryColor,
//                     inactiveTrackColor: Colors.grey,
//                     thumbColor: Theme.of(context).primaryColor,
//                     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
//                     valueIndicatorColor: Theme.of(context).primaryColor,
//                     showValueIndicator: ShowValueIndicator.onlyForDiscrete,
//                   ),
//                   child: rg.RangeSlider(
//                     min: minPrice,
//                     max: maxPrice,
//                     lowerValue: _lowerValue,
//                     upperValue: _upperValue,
//                     divisions: 10,
//                     showValueIndicator: true,
//                     onChanged: (double newLowerValue, double newUpperValue) {
//                       setState(() {
//                         _lowerValue = newLowerValue;
//                         _upperValue = newUpperValue;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               Text("$_upperValue ج.م"),
//             ],
//           ),
//           SizedBox(height: 40),
//           CustomBtn(
//             title: "Filter",
//             color: primaryColor,
//             onPressed: () {},
//           )
//         ],
//       ),
//     );
//   }
// }

// List<Branch> target = [
//   Branch("Female", false),
//   Branch("Male", false),
//   Branch("Kids", false),
//   Branch("Other", false),
// ];

// List<Branch> branch = [
//   Branch("Nike", false),
//   Branch("Statt", false),
//   Branch("Beta", false),
//   Branch("Haraj", false),
//   Branch("Haraj", false),
// ];

// class Branch {
//   String title;
//   bool sel;
//   Branch(this.title, this.sel);
// }
