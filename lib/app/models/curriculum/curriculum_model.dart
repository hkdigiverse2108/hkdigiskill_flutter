class CurriculumModel {
  final String id;
  final CourseInfo? courseId;
  final DateTime? date;
  final String thumbnail;
  final String videoLink;
  final String title;
  final String description;
  final String duration;
  final String attachment;
  final List<CourseLessonAssigned> courseLessonsAssigned;
  final int courseLessonsPriority;
  final bool curriculumLock;
  final bool isDeleted;
  final bool isBlocked;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  CurriculumModel({
    required this.id,
    this.courseId,
    this.date,
    required this.thumbnail,
    required this.videoLink,
    required this.title,
    required this.description,
    required this.duration,
    required this.attachment,
    required this.courseLessonsAssigned,
    required this.courseLessonsPriority,
    required this.curriculumLock,
    required this.isDeleted,
    required this.isBlocked,
    this.createdAt,
    this.updatedAt,
  });

  factory CurriculumModel.fromJson(Map<String, dynamic> json) {
    return CurriculumModel(
      id: json['_id'] ?? '',
      courseId: json['courseId'] != null
          ? CourseInfo.fromJson(json['courseId'])
          : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      thumbnail: json['thumbnail'] ?? '',
      videoLink: json['videoLink'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? '',
      attachment: json['attachment'] ?? '',
      courseLessonsAssigned:
          (json['courseLessonsAssigned'] as List<dynamic>? ?? [])
              .map((e) => CourseLessonAssigned.fromJson(e))
              .toList(),
      courseLessonsPriority: json['courseLessonsPriority'] ?? 0,
      curriculumLock: json['curriculumLock'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "courseId": courseId?.toJson(),
      "date": date?.toIso8601String(),
      "thumbnail": thumbnail,
      "videoLink": videoLink,
      "title": title,
      "description": description,
      "duration": duration,
      "attachment": attachment,
      "courseLessonsAssigned": courseLessonsAssigned
          .map((e) => e.toJson())
          .toList(),
      "courseLessonsPriority": courseLessonsPriority,
      "curriculumLock": curriculumLock,
      "isDeleted": isDeleted,
      "isBlocked": isBlocked,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}

class CourseLessonAssigned {
  final String id;
  final String title;
  final String subtitle;
  final bool lessonLock;
  final int priority;

  CourseLessonAssigned({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.lessonLock,
    required this.priority,
  });

  factory CourseLessonAssigned.fromJson(Map<String, dynamic> json) {
    return CourseLessonAssigned(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      lessonLock: json['lessonLock'] ?? false,
      priority: json['priority'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "title": title,
      "subtitle": subtitle,
      "lessonLock": lessonLock,
      "priority": priority,
    };
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
