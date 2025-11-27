class TestimonialModel {
  String id;
  String image;
  String name;
  String designation;
  int rate;
  String description;
  bool isFeatured;
  String type;
  bool isDeleted;
  bool isBlocked;
  DateTime createdAt;
  DateTime updatedAt;

  TestimonialModel({
    required this.id,
    required this.image,
    required this.name,
    required this.designation,
    required this.rate,
    required this.description,
    required this.isFeatured,
    required this.type,
    required this.isDeleted,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TestimonialModel.fromJson(Map<String, dynamic> json) =>
      TestimonialModel(
        id: json["_id"],
        image: json["image"],
        name: json["name"],
        designation: json["designation"],
        rate: json["rate"],
        description: json["description"],
        isFeatured: json["isFeatured"],
        type: json["type"],
        isDeleted: json["isDeleted"],
        isBlocked: json["isBlocked"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "image": image,
    "name": name,
    "designation": designation,
    "rate": rate,
    "description": description,
    "isFeatured": isFeatured,
    "type": type,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
