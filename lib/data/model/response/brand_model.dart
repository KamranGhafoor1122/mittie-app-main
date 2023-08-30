

// To parse this JSON data, do
//
//     final brandsModel = brandsModelFromJson(jsonString);

import 'dart:convert';

List<BrandsModel> brandsModelFromJson(String str) => List<BrandsModel>.from(json.decode(str).map((x) => BrandsModel.fromJson(x)));

String brandsModelToJson(List<BrandsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BrandsModel {
  int id;
  String name;
  dynamic slug;
  String image;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  BrandsModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandsModel.fromJson(Map<String, dynamic> json) => BrandsModel(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
