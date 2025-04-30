// To parse this JSON data, do
//
//     final categorieModel = categorieModelFromJson(jsonString);

import 'dart:convert';

List<CategorieModel> categorieModelFromJson(String str) =>
    List<CategorieModel>.from(
        json.decode(str).map((x) => CategorieModel.fromJson(x)));

String categorieModelToJson(List<CategorieModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategorieModel {
  final int? id;
  final String? name;
  final String? slug;
  final String? image;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  CategorieModel({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.creationAt,
    this.updatedAt,
  });

  factory CategorieModel.fromJson(Map<String, dynamic> json) => CategorieModel(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        image: json["image"],
        creationAt: json["creationAt"] == null
            ? null
            : DateTime.parse(json["creationAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "image": image,
        "creationAt": creationAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
