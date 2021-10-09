// To parse this JSON data, do
//
//     final placesModel = placesModelFromJson(jsonString);

import 'dart:convert';

List<PlacesModel> placesModelFromJson(String str) => List<PlacesModel>.from(
    json.decode(str).map((x) => PlacesModel.fromJson(x)));

String placesModelToJson(List<PlacesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlacesModel {
  PlacesModel({
    this.city,
    this.zone,
    this.street,
    this.build,
    this.storey,
    this.placeName,
    this.sel,
  });

  String city;
  String zone;
  String street;
  String build;
  String storey;
  bool sel;
  String placeName;

  factory PlacesModel.fromJson(Map<String, dynamic> json) => PlacesModel(
        city: json["city"] == null ? null : json["city"],
        sel: json["sel"] == null ? null : json["sel"],
        zone: json["zone"] == null ? null : json["zone"],
        street: json["street"] == null ? null : json["street"],
        build: json["build"] == null ? null : json["build"],
        storey: json["storey"] == null ? null : json["storey"],
        placeName: json["place_name"] == null ? null : json["place_name"],
      );

  Map<String, dynamic> toJson() => {
        "city": city == null ? null : city,
        "zone": zone == null ? null : zone,
        "street": street == null ? null : street,
        "build": build == null ? null : build,
        "sel": sel == null ? null : sel,
        "storey": storey == null ? null : storey,
        "place_name": placeName == null ? null : placeName,
      };
}
