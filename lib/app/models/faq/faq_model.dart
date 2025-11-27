class FaqModel {
  String id;
  String question;
  String answer;
  bool isFeatured;
  String type;
  bool isDeleted;
  bool isBlocked;
  DateTime createdAt;
  DateTime updatedAt;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.isFeatured,
    required this.type,
    required this.isDeleted,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
    id: json["_id"],
    question: json["question"],
    answer: json["answer"],
    isFeatured: json["isFeatured"],
    type: json["type"],
    isDeleted: json["isDeleted"],
    isBlocked: json["isBlocked"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "answer": answer,
    "isFeatured": isFeatured,
    "type": type,
    "isDeleted": isDeleted,
    "isBlocked": isBlocked,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
