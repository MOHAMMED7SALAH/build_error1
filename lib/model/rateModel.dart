// To parse this JSON data, do
//
//     final rateModel = rateModelFromJson(jsonString);

import 'dart:convert';

List<RateModel> rateModelFromJson(String str) =>
    List<RateModel>.from(json.decode(str).map((x) => RateModel.fromJson(x)));

String rateModelToJson(List<RateModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RateModel {
  RateModel({
    this.user,
    this.comment,
    this.rate,  
  });

  String user;
  String comment;
  String rate;

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
        user: json["user"] == null ? "" : json["user"],
        comment: json["comment"] == "" ? null : json["comment"],
        rate: json["rate"] == null ? "" : json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "user": user == null ? null : user,
        "comment": comment == null ? null : comment,
        "rate": rate == null ? null : rate,
      };
}
