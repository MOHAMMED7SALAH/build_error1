// To parse this JSON data, do
//
//     final langModel = langModelFromJson(jsonString);

import 'dart:convert';

List<LangModel> langModelFromJson(String str) =>
    List<LangModel>.from(json.decode(str).map((x) => LangModel.fromJson(x)));

String langModelToJson(List<LangModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LangModel {
  LangModel({
    this.id,
    this.word,
    this.keyId,
    this.lang,
  });

  String id;
  String word;
  String keyId;
  Lang lang;

  factory LangModel.fromJson(Map<String, dynamic> json) => LangModel(
        id: json["id"] == null ? null : json["id"],
        word: json["word"] == null ? null : json["word"],
        keyId: json["key_id"] == null ? null : json["key_id"],
        lang: json["lang"] == null ? null : langValues.map[json["lang"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "word": word == null ? null : word,
        "key_id": keyId == null ? null : keyId,
        "lang": lang == null ? null : langValues.reverse[lang],
      };
}

enum Lang { ARABIC }

final langValues = EnumValues({"arabic": Lang.ARABIC});

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
