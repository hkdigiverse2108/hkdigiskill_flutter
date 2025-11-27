class CategoriesModel {
  String id;
  String name;
  String? image;
  String description;
  bool isFeatured;
  bool isDeleted;
  bool isBlocked;
  DateTime createdAt;
  DateTime updatedAt;

  CategoriesModel({
    required this.id,
    required this.name,
    this.image,
    required this.description,
    required this.isFeatured,
    required this.isDeleted,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        id: json["_id"],
        name: json["name"],
        image: json["image"],
        description: json["description"],
        isFeatured: json["isFeatured"],
        isDeleted: json["isDeleted"],
        isBlocked: json["isBlocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "image": image,
    "description": description,
    "isFeatured": isFeatured,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
