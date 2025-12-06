import 'package:flutter/material.dart';

class CourseModel {
  final String? id;
  final String? name;
  final CourseCategoryModel? courseCategory;
  final List<dynamic>? courseCurriculumIds;
  final String? description;
  final num? price;
  final num? mrpPrice;
  final String? image;
  final bool? purchasedCoursesShow;
  final num? enrolledLearners;
  final num? classCompleted;
  final num? satisfactionRate;
  final int? duration;
  final String? language;
  final num? totalLesson;
  final bool? isDeleted;
  final bool? isBlocked;
  final bool? isUnlocked;
  final String? createdAt;
  final String? updatedAt;
  final String? pdf;
  num averageRating;
  num totalRated;

  CourseModel({
    this.id,
    this.name,
    this.courseCategory,
    this.courseCurriculumIds,
    this.description,
    this.price,
    this.mrpPrice,
    this.image,
    this.purchasedCoursesShow,
    this.enrolledLearners,
    this.classCompleted,
    this.satisfactionRate,
    this.duration,
    this.language,
    this.totalLesson,
    this.isDeleted,
    this.isBlocked,
    this.createdAt,
    this.updatedAt,
    this.pdf,
    this.isUnlocked,
    this.averageRating = 0,
    this.totalRated = 0,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json["_id"],
      name: json["name"],
      courseCategory: json["courseCategoryId"] != null
          ? CourseCategoryModel.fromJson(json["courseCategoryId"])
          : null,
      courseCurriculumIds: json["courseCurriculumIds"] ?? [],
      description: json["description"],
      price: json["price"],
      mrpPrice: json["mrpPrice"],
      image: json["image"],
      purchasedCoursesShow: json["purchasedCoursesShow"],
      enrolledLearners: json["enrolledLearners"],
      classCompleted: json["classCompleted"],
      satisfactionRate: json["satisfactionRate"],
      duration: json["duration"],
      language: json["language"],
      totalLesson: json["totalLesson"],
      isDeleted: json["isDeleted"],
      isBlocked: json["isBlocked"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      pdf: json["pdf"],
      isUnlocked: json["isUnlocked"],
      averageRating: 0,
      totalRated: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "courseCategoryId": courseCategory?.toJson(),
      "courseCurriculumIds": courseCurriculumIds,
      "description": description,
      "price": price,
      "mrpPrice": mrpPrice,
      "image": image,
      "purchasedCoursesShow": purchasedCoursesShow,
      "enrolledLearners": enrolledLearners,
      "classCompleted": classCompleted,
      "satisfactionRate": satisfactionRate,
      "duration": duration,
      "language": language,
      "totalLesson": totalLesson,
      "isDeleted": isDeleted,
      "isBlocked": isBlocked,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
    };
  }
}

class CourseCategoryModel {
  final String? id;
  final String? name;
  final String? description;

  CourseCategoryModel({this.id, this.name, this.description});

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) {
    return CourseCategoryModel(
      id: json["_id"],
      name: json["name"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name, "description": description};
  }
}

class Lesson {
  final IconData icon;
  final String title;
  final String uploadedDate;
  final String duration;

  Lesson({
    required this.icon,
    required this.title,
    required this.uploadedDate,
    required this.duration,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      icon: json['icon'] as IconData,
      title: json['title'] as String,
      uploadedDate: json['uploadedDate'] as String,
      duration: json['duration'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'icon': icon,
    'title': title,
    'uploadedDate': uploadedDate,
    'duration': duration,
  };
}

class Section {
  final String sectionTitle;
  final List<Lesson> lessons;

  Section({required this.sectionTitle, required this.lessons});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      sectionTitle: json['sectionTitle'] as String,
      lessons: (json['lessons'] as List)
          .map((lesson) => Lesson.fromJson(lesson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'sectionTitle': sectionTitle,
    'lessons': lessons.map((lesson) => lesson.toJson()).toList(),
  };
}
