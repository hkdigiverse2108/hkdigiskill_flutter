class InstructorModel {
  final String id;
  final String? image;
  final String name;
  final String? designation;
  final String? linkedin;
  final String? instagram;
  final String? facebook;
  final String? twitter;
  final bool isDeleted;
  final bool isBlocked;

  InstructorModel({
    required this.id,
    required this.image,
    required this.name,
    required this.designation,
    required this.linkedin,
    required this.instagram,
    required this.facebook,
    required this.twitter,
    required this.isDeleted,
    required this.isBlocked,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) {
    return InstructorModel(
      id: json["_id"] ?? "",
      image: json["image"],
      name: json["name"] ?? "",
      designation: json["designation"],
      linkedin: json["linkedin"],
      instagram: json["instagram"],
      facebook: json["facebook"],
      twitter: json["twitter"],
      isDeleted: json["isDeleted"] ?? false,
      isBlocked: json["isBlocked"] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "image": image,
      "name": name,
      "designation": designation,
      "linkedin": linkedin,
      "instagram": instagram,
      "facebook": facebook,
      "twitter": twitter,
      "isDeleted": isDeleted,
      "isBlocked": isBlocked,
    };
  }
}
