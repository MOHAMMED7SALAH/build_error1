// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  OrderModel(
      {this.id,
      this.city,
      this.zone,
      this.street,
      this.build,
      this.storey,
      this.timeFrom,
      this.timeTo,
      this.orderStatus,
      this.date,
      this.maxTotal,
      this.vis});

  String id;
  String city;
  String zone;
  String street;
  String build;
  String storey;
  String timeFrom;
  String timeTo;
  String orderStatus;
  bool vis = false;
  DateTime date;
  double maxTotal;
  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"] == null ? null : json["id"],
        city: json["city"] == null ? null : json["city"],
        zone: json["zone"] == null ? null : json["zone"],
        street: json["street"] == null ? null : json["street"],
        build: json["build"] == null ? null : json["build"],
        storey: json["storey"] == null ? null : json["storey"],
        timeFrom: json["time_from"] == null ? null : json["time_from"],
        timeTo: json["time_to"] == null ? null : json["time_to"],
        orderStatus: json["order_status"] == null ? null : json["order_status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "city": city == null ? null : city,
        "zone": zone == null ? null : zone,
        "street": street == null ? null : street,
        "build": build == null ? null : build,
        "storey": storey == null ? null : storey,
        "time_from": timeFrom == null ? null : timeFrom,
        "time_to": timeTo == null ? null : timeTo,
        "order_status": orderStatus == null ? null : orderStatus,
        "date": date == null
            ? null
            : "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
