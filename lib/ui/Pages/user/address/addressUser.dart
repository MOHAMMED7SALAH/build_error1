// import 'package:date_time_picker/date_time_picker.dart' as time;
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:saffi/controller/langController.dart';
import 'package:saffi/controller/userController.dart';
import 'package:saffi/controller/userPlacesController.dart';
import 'package:saffi/helper/appLocalization.dart';
import 'package:saffi/helper/loadingApp.dart';
import 'package:saffi/helper/navigation.dart';
import 'package:saffi/helper/style.dart';
import 'package:saffi/helper/succPage.dart';
import 'package:saffi/model/places/model.dart';
import 'package:saffi/ui/Pages/user/address/addAdress.dart';
import 'package:saffi/ui/widget/CustomBtn.dart';
import 'package:saffi/ui/widget/CustomFeild.dart';
import 'package:saffi/ui/widget/customSearchAppBar.dart';
import 'package:saffi/ui/widget/custom_alert.dart';
import 'package:intl/intl.dart' as time;

class MyAddressPage extends StatefulWidget {
  final bool chckout;
  final int type;
  final String id;

  const MyAddressPage(
      {Key key, this.chckout, @required this.type, @required this.id})
      : super(key: key);
  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  @override
  void initState() {
    Provider.of<PlasesController>(context, listen: false).getData();
    super.initState();
  }

  final f = time.DateFormat('yyyy-MM-dd // hh:mm');
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var palce = Provider.of<PlasesController>(context, listen: true);
    return Directionality(
      textDirection: localization.text("lang") == "ar"
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: customAppBar(context, title: localization.text("MyAddress")),
        body: loading == true
            ? Loading
            : ListView(
                children: [
                  ListView.builder(
                    itemCount: palce.palaces.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = palce.palaces[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: accentColor,
                                ),
                                onPressed: () {
                                  palce.removePlace(context, item);
                                },
                              ),
                            ),
                            Container(
                              height: 120,
                              // height: MediaQuery.of(context).size.height * 0.2,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title:
                                          Text(palce.palaces[index].placeName),
                                      subtitle: Text(
                                          "${item.city} - ${item.zone} - ${item.street} - ${item.storey} - ${item.build}"),
                                    ),
                                  ),
                                  Container(
                                    child: Radio(
                                      groupValue:
                                          item.sel == true ? true : false,
                                      activeColor: Color(0xFFDE4D0D),
                                      value: true,
                                      onChanged: (v) {
                                        for (int i = 0;
                                            i < palce.palaces.length;
                                            i++) {
                                          if (i == index) {
                                            setState(() {
                                              palce.palaces[i].sel = true;
                                              Provider.of<PlasesController>(
                                                      context,
                                                      listen: false)
                                                  .savgeData();
                                            });
                                          } else {
                                            setState(() {
                                              palce.palaces[i].sel = false;
                                              Provider.of<PlasesController>(
                                                      context,
                                                      listen: false)
                                                  .savgeData();
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  if (widget.chckout == true)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          SizedBox(height: 10),
                          Text(
                            localization.text("selecteitine"),
                            style: boldStyle.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:
                                      Text(localization.text("form") + " :")),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 3,
                                child: CustomBtn(
                                  title: f.format(from),
                                  onPressed: () {
                                    DatePicker.showDateTimePicker(
                                      context,
                                      showTitleActions: true,
                                      theme: DatePickerTheme(),
                                      minTime: DateTime(2018, 3, 5),
                                      maxTime: DateTime(2019, 6, 7),
                                      onChanged: (date) {
                                        print('change $date');
                                      },
                                      onConfirm: (date) {
                                        print('confirm $date');
                                        setState(() {
                                          from = date;
                                        });
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(localization.text("to") + " :")),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 3,
                                child: CustomBtn(
                                  title: f.format(to),
                                  onPressed: () {
                                    DatePicker.showDateTimePicker(
                                      context,
                                      showTitleActions: true,
                                      theme: DatePickerTheme(),
                                      minTime: DateTime.now(),
                                      maxTime: DateTime(2025, 11, 13),
                                      onChanged: (date) {
                                        print('change $date');
                                      },
                                      onConfirm: (date) {
                                        setState(() {
                                          to = date;
                                        });
                                      },
                                      currentTime: DateTime.now(),
                                      locale: LocaleType.ar,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          // CustomFeild(
                          //   controller: to,
                          //   hint: f.format(date),
                          //   title: localization.text("to"),
                          // ),
                        ],
                      ),
                    ),
                  SizedBox(height: 50),
                  if (widget.chckout == true)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomBtn(
                          title: localization.text("confirm"),
                          color: primaryColor,
                          onPressed: () async {
                            PlacesModel place = Provider.of<PlasesController>(
                                    context,
                                    listen: false)
                                .getPlaceItem();
                            if (place != null) {
                              setState(() {
                                loading = true;
                              });
                              await Provider.of<UserController>(context,
                                      listen: false)
                                  .checkOut(
                                context,
                                // name: nameController.text,
                                // phone: phoneController.text,
                                id: widget.id,
                                type: widget.type,
                                build: place.build,
                                city: place.city,
                                storey: place.storey,
                                street: place.street,
                                from: from.toString(),
                                to: to.toString(),
                                zoon: place.zone,
                              )
                                  .then((value) {
                                if (value == true) {
                                  loading = false;
                                  removeUntil(context, SuccPage());
                                } else {
                                  setState(() {
                                    loading = false;
                                  });
                                }
                              });
                            } else {
                              CustomAlert().toast(
                                  context: context,
                                  title:
                                      localization.text("Plaseselectaddress"));
                            }
                          }),
                    )
                ],
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            push(context, AddAdress());
          },
        ),
      ),
    );
  }
}
