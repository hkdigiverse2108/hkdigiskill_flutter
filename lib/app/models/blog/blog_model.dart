class BlogModel {
  String id;
  String title;
  String? subTitle;
  String content;
  String category;
  String coverImage;
  String mainImage;
  String author;
  bool isFeatured;
  bool isDeleted;
  bool isBlocked;
  DateTime createdAt;
  DateTime updatedAt;
  String? quote;

  BlogModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.content,
    required this.category,
    required this.coverImage,
    required this.mainImage,
    required this.author,
    required this.isFeatured,
    required this.isDeleted,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
    this.quote,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) => BlogModel(
    id: json["_id"],
    title: json["title"],
    subTitle: json["subTitle"],
    content: json["content"],
    category: json["category"],
    coverImage: json["coverImage"],
    mainImage: json["mainImage"],
    author: json["author"],
    isFeatured: json["isFeatured"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    quote: json["quote"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "subTitle": subTitle,
    "content": content,
    "category": category,
    "coverImage": coverImage,
    "mainImage": mainImage,
    "author": author,
    "isFeatured": isFeatured,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "quote": quote,
  };
}
