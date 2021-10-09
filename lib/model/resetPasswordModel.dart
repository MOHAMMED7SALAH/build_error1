// To parse this JSON data, do
//
//     final editPasswordModel = editPasswordModelFromJson(jsonString);

import 'dart:convert';

EditPasswordModel editPasswordModelFromJson(String str) =>
    EditPasswordModel.fromJson(json.decode(str));

String editPasswordModelToJson(EditPasswordModel data) =>
    json.encode(data.toJson());

class EditPasswordModel {
  EditPasswordModel({
    this.errors,
    this.message,
  });

  List<String> errors;
  String message;

  factory EditPasswordModel.fromJson(Map<String, dynamic> json) =>
      EditPasswordModel(
        errors: json["errors"] == null
            ? null
            : List<String>.from(json["errors"].map((x) => x)),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "errors":
            errors == null ? null : List<dynamic>.from(errors.map((x) => x)),
        "message": message == null ? null : message,
      };
}
