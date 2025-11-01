import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';

class CourseDetailsController extends GetxController {
  final selectedTab = 0.obs;
  var isPurchased = false.obs;

  final List<Tabs> tabs = [
    Tabs(title: "About"),
    Tabs(title: "Curriculum"),
    Tabs(title: "Testimonials"),
    Tabs(title: "FAQ's"),
  ];

  final faqs = [
    FaqItem(
      "How can I contact a school directly?",
      "Lorem ipsum dolor sit amet consectetur adipiscing elit sed eiusmod tempor incididunt labore dolore magna aliqua enim ad minim.",
    ),
    FaqItem(
      "How do I find a school where I want to study?",
      "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
    ),
    FaqItem(
      "Where should I study abroad?",
      "Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam.",
    ),
  ];

  final List<Section> curriculum = [
    Section(
      sectionTitle: "1. Introduction of IT Course",
      lessons: [
        Lesson(
          icon: Icons.play_arrow,
          title: "Introduction to the art course",
          uploadedDate: "28-11-2025",
          duration: "08 Min",
        ),
        Lesson(
          icon: Icons.play_arrow,
          title: "How to be successful in art industry",
          uploadedDate: "28-11-2025",
          duration: "08 Min",
        ),
      ],
    ),
    Section(
      sectionTitle: "2. Introduction of IT Course",
      lessons: [
        Lesson(
          icon: Icons.play_arrow,
          title: "Introduction to the art course",
          uploadedDate: "28-11-2025",
          duration: "08 Min",
        ),
      ],
    ),
  ];

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

class Tabs {
  final String title;

  Tabs({required this.title});
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem(this.question, this.answer);
}
