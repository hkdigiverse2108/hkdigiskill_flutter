import 'package:hkdigiskill/app/models/curriculum/curriculum_model.dart';

class LessonModel {
  final String id;
  final CourseInfo? courseId;
  final String title;
  final String subtitle;
  final bool lessonLock;
  final bool isDeleted;
  final bool isBlocked;
  final int priority;
  List<CurriculumModel> curriculum; // NEW FIELD
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LessonModel({
    required this.id,
    this.courseId,
    required this.title,
    required this.subtitle,
    required this.lessonLock,
    required this.isDeleted,
    required this.isBlocked,
    required this.priority,
    this.curriculum = const [], // NEW DEFAULT
    this.createdAt,
    this.updatedAt,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['_id'] ?? '',
      courseId: json['courseId'] != null
          ? CourseInfo.fromJson(json['courseId'])
          : null,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      lessonLock: json['lessonLock'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      priority: json['priority'] ?? 999,
      curriculum: [],
      // will fill later
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }
}

class CourseInfo {
  final String id;
  final String name;
  final String description;

  CourseInfo({required this.id, required this.name, required this.description});

  factory CourseInfo.fromJson(Map<String, dynamic> json) {
    return CourseInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"_id": id, "name": name, "description": description};
  }
}
