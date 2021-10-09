// To parse this JSON data, do
//
//     final orderItemsModel = orderItemsModelFromJson(jsonString);

import 'dart:convert';

List<OrderItemsModel> orderItemsModelFromJson(String str) =>
    List<OrderItemsModel>.from(
        json.decode(str).map((x) => OrderItemsModel.fromJson(x)));

String orderItemsModelToJson(List<OrderItemsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderItemsModel {
  OrderItemsModel({
    this.id,
    this.itemId,
    this.name,
    this.price,
    this.qty,
    this.total,
  });

  String id;
  String itemId;
  String name;
  String price;
  String qty;
  String total;

  factory OrderItemsModel.fromJson(Map<String, dynamic> json) =>
      OrderItemsModel(
        id: json["id"] == null ? null : json["id"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        name: json["name"] == null ? null : json["name"],
        price: json["price"] == null ? null : json["price"],
        qty: json["qty"] == null ? null : json["qty"],
        total: json["total"] == null ? null : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "item_id": itemId == null ? null : itemId,
        "name": name == null ? null : name,
        "price": price == null ? null : price,
        "qty": qty == null ? null : qty,
        "total": total == null ? null : total,
      };
}
