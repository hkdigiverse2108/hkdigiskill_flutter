class WorkshopModel {
  final String? id;
  final String? image;
  final String? title;
  final String? subTitle;
  final String? about;
  final List<dynamic>? workshopCurriculum;
  final List<dynamic>? workshopTestimonials;
  final List<dynamic>? workshopFAQ;
  final num? price;
  final num? mrpPrice;
  final String? validFor;
  final String? language;
  final String? duration;
  final bool? isDeleted;
  final bool? isBlocked;
  final String? createdAt;
  final String? updatedAt;
  final bool? isUnlocked;
  final String? pdfAttach;
  num? averageRating;
  num? totalRated;

  WorkshopModel({
    this.id,
    this.image,
    this.title,
    this.subTitle,
    this.about,
    this.workshopCurriculum,
    this.workshopTestimonials,
    this.workshopFAQ,
    this.price,
    this.mrpPrice,
    this.validFor,
    this.language,
    this.duration,
    this.isDeleted,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.isUnlocked,
    this.pdfAttach,
    this.averageRating,
    this.totalRated,
  });

  factory WorkshopModel.fromJson(Map<String, dynamic> json) {
    return WorkshopModel(
      id: json["_id"],
      image: json["image"],
      title: json["title"],
      subTitle: json["subTitle"],
      about: json["about"],
      workshopCurriculum: json["workshopCurriculum"] ?? [],
      workshopTestimonials: json["workshopTestimonials"] ?? [],
      workshopFAQ: json["workshopFAQ"] ?? [],
      price: json["price"],
      mrpPrice: json["mrpPrice"],
      validFor: json["validFor"],
      language: json["language"],
      duration: json["duration"],
      isDeleted: json["isDeleted"],
      isBlocked: json["isBlocked"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      isUnlocked: json["isUnlocked"],
      pdfAttach: json["pdfAttach"],
      averageRating: json["averageRating"] ?? 0,
      totalRated: json["totalRated"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "image": image,
      "title": title,
      "subTitle": subTitle,
      "about": about,
      "workshopCurriculum": workshopCurriculum,
      "workshopTestimonials": workshopTestimonials,
      "workshopFAQ": workshopFAQ,
      "price": price,
      "mrpPrice": mrpPrice,
      "validFor": validFor,
      "language": language,
      "duration": duration,
      "isDeleted": isDeleted,
      "isBlocked": isBlocked,
      "createdAt": createdAt,
      "pdfAttach": pdfAttach,
      "updatedAt": updatedAt,
      "isUnlocked": isUnlocked,
    };
  }
}
