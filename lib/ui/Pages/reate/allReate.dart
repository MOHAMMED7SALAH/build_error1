import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/mainController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/ui/widget/CustomReateStar.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';

import 'addRatePage.dart';

class AllRatePage extends StatefulWidget {
  final String id;
  final double rate;

  const AllRatePage({Key key, this.id, this.rate}) : super(key: key);
  @override
  _AllRatePageState createState() => _AllRatePageState();
}

class _AllRatePageState extends State<AllRatePage> {
  @override
  void initState() {
    Provider.of<MainController>(context, listen: false)
        .getRate(context, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var rateContr = Provider.of<MainController>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(context),
        body: rateContr.loading == true
            ? Loading
            : ListView(
                padding: EdgeInsets.all(15),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localization.text("allReview"),
                                style: boldStyle,
                              ),
                            ],
                          ),
                          SizedBox(width: 10),
                          Text("("),
                          CustomReateBar(
                            size: 20,
                            rate: widget.rate,
                          ),
                          Text(")")
                        ],
                      ),
                      FlatButton(
                        onPressed: () => push(
                            context,
                            AddRatePage(
                              id: widget.id,
                            )),
                        child: Text(
                          localization.text("writeArevirw"),
                          style: boldStyle.copyWith(
                              color: primaryColor, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   height: MediaQuery.of(context).size.height * 0.06,
                  //   width: double.infinity,
                  //   child: Row(
                  //     children: [
                  //       Text("Filter", style: lightStyle),
                  //       SizedBox(width: 10),
                  //       Expanded(
                  //         child: ListView.builder(
                  //           itemCount: filterRate.length,
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder: (context, index) {
                  //             return InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   for (int i = 0; i < filterRate.length; i++) {
                  //                     if (i == index) {
                  //                       filterRate[i].sel = true;
                  //                     } else {
                  //                       filterRate[i].sel = false;
                  //                     }
                  //                   }
                  //                 });
                  //               },
                  //               child: Container(
                  //                 padding: EdgeInsets.all(10),
                  //                 margin: EdgeInsets.all(5),
                  //                 decoration: BoxDecoration(
                  //                   color: Colors.white,
                  //                   border: Border.all(
                  //                     color: filterRate[index].sel == true
                  //                         ? primaryColor
                  //                         : Colors.white,
                  //                   ),
                  //                   borderRadius: BorderRadius.circular(10),
                  //                 ),
                  //                 child: Row(
                  //                   children: [
                  //                     Icon(
                  //                       Icons.star,
                  //                       color: Colors.amber,
                  //                       size: 15,
                  //                     ),
                  //                     Text("{filterRate[index].title}")
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      rateContr.rate.length,
                      (index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(1000),
                                    child: Image.asset(
                                      "assets/images/3.png",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${rateContr.rate[index].user}",
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "${rateContr.rate[index].comment}",
                                        maxLines: 2,
                                      ),
                                      SizedBox(height: 10),
                                      CustomReateBar(
                                        size: 20,
                                        rate: double.parse(
                                            rateContr.rate[index].rate),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

List<FliterRate> filterRate = [
  FliterRate(true, "All"),
  FliterRate(false, "5"),
  FliterRate(false, "4"),
  FliterRate(false, "3"),
  FliterRate(false, "2"),
  FliterRate(false, "1"),
];

class FliterRate {
  String title;
  bool sel;
  FliterRate(this.sel, this.title);
}
