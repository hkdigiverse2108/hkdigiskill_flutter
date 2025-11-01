import 'package:flutter/material.dart';

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

  Section({
    required this.sectionTitle,
    required this.lessons,
  });

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
