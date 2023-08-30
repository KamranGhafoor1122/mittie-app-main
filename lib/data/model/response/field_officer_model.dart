
// To parse this JSON data, do
//
//     final fieldOfficerModel = fieldOfficerModelFromJson(jsonString);

import 'dart:convert';

List<FieldOfficerModel> fieldOfficerModelFromJson(String str) => List<FieldOfficerModel>.from(json.decode(str).map((x) => FieldOfficerModel.fromJson(x)));

String fieldOfficerModelToJson(List<FieldOfficerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FieldOfficerModel {
  int id;
  String name;
  String address;
  String image;
  String location;
  String coordinates;
  String contactDetails;
  dynamic userId;
  DateTime createdAt;
  DateTime updatedAt;

  FieldOfficerModel({
    this.id,
    this.name,
    this.address,
    this.location,
    this.image,
    this.coordinates,
    this.contactDetails,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory FieldOfficerModel.fromJson(Map<String, dynamic> json) => FieldOfficerModel(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    location: json["location"],
    image: json["image"],
    coordinates: json["coordinates"],
    contactDetails: json["contact_details"],
    userId: json["user_id"],
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]):null,
    updatedAt: json["updated_at"] != null ?  DateTime.parse(json["updated_at"]):null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "location": location,
    "image": image,
    "coordinates": coordinates,
    "contact_details": contactDetails,
    "user_id": userId,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
