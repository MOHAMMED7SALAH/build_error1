import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:saffi/model/places/model.dart';
import 'package:saffi/ui/widget/custom_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlasesController extends ChangeNotifier {
  List<PlacesModel> palaces = [];
  SharedPreferences _preferences;
  CustomAlert _alert = CustomAlert();

  Future<bool> addPlaces(BuildContext context, String city, String zone,
      String street, String build, String storey, String palcename) async {
    palaces.add(PlacesModel(
      build: build,
      city: city,
      storey: storey,
      street: street,
      zone: zone,
      placeName: palcename,
    ));
    savgeData();
    _alert.toast(context: context, title: "place add sucssesfull");
    notifyListeners();
    return true;
  }

  savgeData() async {
    _preferences = await SharedPreferences.getInstance();
    List<String> items =
        palaces.map((item) => json.encode(item.toJson())).toList();

    _preferences.setStringList("Places", items);
    print(items);
    notifyListeners();
  }

  removePlace(BuildContext context, PlacesModel place) {
    palaces.remove(place);
    savgeData();
    _alert.toast(context: context, title: "place remove sucssesfull");
    notifyListeners();
  }

  getData() async {
    _preferences = await SharedPreferences.getInstance();
    List<String> data = _preferences.getStringList("Places");
    if (data != null) {
      palaces =
          data.map((item) => PlacesModel.fromJson(json.decode(item))).toList();
    } else {
      palaces = [];
      notifyListeners();
    }
    notifyListeners();
  }

  PlacesModel getPlaceItem() {
    int indexOfaboutApp = palaces.indexWhere((e) => e.sel == true);
    notifyListeners();
    return indexOfaboutApp == -1 ? null : palaces[indexOfaboutApp];
  }
}
