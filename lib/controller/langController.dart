import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:saffi/model/langModel.dart';
import 'package:saffi/repo/NetworkUtlis.dart';
import 'package:saffi/ui/widget/custom_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangContoller extends ChangeNotifier {
  NetworkUtil _util = NetworkUtil();
  CustomAlert _alert = CustomAlert();
  List<LangModel> langList = [];
  SharedPreferences _preferences;
  Future<bool> getLang(BuildContext context, String langCode) async {
    _preferences = await SharedPreferences.getInstance();
    Response response = await _util.get("lang_translations.php?code=$langCode");
    if (response == null) {
      print("no internet");
      _alert.networckDialog(context);
      return false;
    } else {
      print("getLangsucss");
      langList = List<LangModel>.from(
          json.decode(response.data).map((x) => LangModel.fromJson(x)));
      print("${json.decode(response.data)}");
      _preferences.setString("lang", response.data);
      notifyListeners();
      return true;
    }
  }

  getWord(String keyId) {
    int index = langList.indexWhere((e) => e.keyId == "$keyId");
    return langList[index].word;
  }

  Future<bool> getStorgeLang(BuildContext context) async {
    print("getting Lang");
    _preferences = await SharedPreferences.getInstance();
    String data = _preferences.getString("lang");
    if (data != null) {
      print("حاحا");
      langList = List<LangModel>.from(
          json.decode(data).map((x) => LangModel.fromJson(x)));
      notifyListeners();
      return true;
    } else {
      print("$data ++++++++++");
      bool ret = await getLang(context, "ar");
      notifyListeners();
      return ret;
    }
  }
}
