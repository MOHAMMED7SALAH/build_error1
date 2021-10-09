// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel productsModelFromJson(String str) =>
    ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    this.massage,
    this.data,
  });

  String massage;
  List<ProductDatum> data;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        massage: json["massage"] == null ? null : json["massage"],
        data: json["data"] == null
            ? null
            : List<ProductDatum>.from(
                json["data"].map((x) => ProductDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "massage": massage == null ? null : massage,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ProductDatum {
  ProductDatum(
      {this.id,
      this.name,
      this.mainImg,
      this.description,
      this.shortDesc,
      this.price,
      this.price2,
      this.unite,
      this.unite2,
      this.points,
      this.decimalNumber,
      this.additionalImages,
      this.discount,
      this.orderProduct,
      this.availability,
      this.category,
      this.total,
      this.bestSeller,
      this.newArrivals,
      this.qtp,
      this.featured,
      this.rate,
      this.dealOfDay,
      this.dicount,
      this.idCart});

  String id;
  String name;
  String mainImg;
  String description;
  Price2 shortDesc;
  String idCart;
  String dicount;
  String price;
  String qtp;
  Price2 price2;
  String unite;
  Price2 unite2;
  String points;
  String decimalNumber;
  List<String> additionalImages;
  String discount;
  String orderProduct;
  String total;
  Availability availability;
  String category;
  DealOfDay bestSeller;
  DealOfDay newArrivals;
  DealOfDay featured;
  DealOfDay dealOfDay;
  double rate;

  factory ProductDatum.fromJson(Map<String, dynamic> json) => ProductDatum(
        id: json["id"] == null ? json["product_id"] : json["id"],
        name: json["name"] == null ? json["product_name"] : json["name"],
        dicount: json["dicount"] == null ||
                json["dicount"] == "0" ||
                json["dicount"] == ""
            ? null
            : json["dicount"],
        mainImg: json["main_img"] == null ? null : json["main_img"],
        idCart: json["id_cart"] == null ? null : json["id_cart"],
        total: json["total"] == null ? null : json["total"],
        description: json["description"] == null ? null : json["description"],
        rate: json["product_average_rating"] == null
            ? 0
            : double.parse(json["product_average_rating"]),
        shortDesc: json["short_desc"] == null
            ? null
            : price2Values.map[json["short_desc"]],
        qtp: json["qty"] == null ? "1" : json["qty"],
        price: json["price"] == null ? null : json["price"],
        price2:
            json["price2"] == null ? null : price2Values.map[json["price2"]],
        unite: json["unite"] == null ? null : json["unite"],
        unite2:
            json["unite2"] == null ? null : price2Values.map[json["unite2"]],
        points: json["points"] == null ? null : json["points"],
        decimalNumber:
            json["Decimal_number"] == null ? null : json["Decimal_number"],
        additionalImages: json["additional_images"] == null
            ? [json["main_img"]]
            : List<String>.from(json["additional_images"].map((x) => x)),
        discount: json["discount"] == null ? null : json["discount"],
        orderProduct:
            json["order_product"] == null ? null : json["order_product"],
        availability: json["Availability"] == null
            ? null
            : availabilityValues.map[json["Availability"]],
        category: json["category"] == null ? null : json["category"],
        bestSeller: json["best_seller"] == null
            ? null
            : dealOfDayValues.map[json["best_seller"]],
        newArrivals: json["new_arrivals"] == null
            ? null
            : dealOfDayValues.map[json["new_arrivals"]],
        featured: json["featured"] == null
            ? null
            : dealOfDayValues.map[json["featured"]],
        dealOfDay: json["Deal_Of_Day"] == null
            ? null
            : dealOfDayValues.map[json["Deal_Of_Day"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "main_img": mainImg == null ? null : mainImg,
        "description": description == null ? null : description,
        "short_desc":
            shortDesc == null ? null : price2Values.reverse[shortDesc],
        "price": price == null ? null : price,
        "price2": price2 == null ? null : price2Values.reverse[price2],
        "unite": unite == null ? null : uniteValues.reverse[unite],
        "unite2": unite2 == null ? null : price2Values.reverse[unite2],
        "points": points == null ? null : points,
        "Decimal_number": decimalNumber == null ? null : decimalNumber,
        "additional_images": additionalImages == null
            ? null
            : List<dynamic>.from(additionalImages.map((x) => x)),
        "discount": discount == null ? null : dealOfDayValues.reverse[discount],
        "order_product": orderProduct == null ? null : orderProduct,
        "Availability": availability == null
            ? null
            : availabilityValues.reverse[availability],
        "category": category == null ? null : categoryValues.reverse[category],
        "best_seller":
            bestSeller == null ? null : dealOfDayValues.reverse[bestSeller],
        "new_arrivals":
            newArrivals == null ? null : dealOfDayValues.reverse[newArrivals],
        "featured": featured == null ? null : dealOfDayValues.reverse[featured],
        "Deal_Of_Day":
            dealOfDay == null ? null : dealOfDayValues.reverse[dealOfDay],
      };
}

enum Availability { EMPTY, AVAILABILITY }

final availabilityValues = EnumValues({
  "غير متوفر فى المخزن": Availability.AVAILABILITY,
  "متوفر فى المخزن": Availability.EMPTY
});

enum DealOfDay { NO, YES }

final dealOfDayValues = EnumValues({"no": DealOfDay.NO, "yes": DealOfDay.YES});

enum Category { EMPTY }

final categoryValues = EnumValues({"خضروات وفواكه": Category.EMPTY});

enum Price2 { EMPTY }

final price2Values = EnumValues({"empty": Price2.EMPTY});

enum Unite { EMPTY, BOX }

final uniteValues = EnumValues({"box": Unite.BOX, "كجم": Unite.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
