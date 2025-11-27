import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';
import 'package:hkdigiskill/app/models/faq/faq_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';

class CourseDetailsController extends GetxController {
  final selectedTab = 0.obs;
  var isPurchased = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getFaqs();
  }

  final List<Tabs> tabs = [
    Tabs(title: "About"),
    Tabs(title: "Curriculum"),
    Tabs(title: "Testimonials"),
    Tabs(title: "FAQ's"),
  ];

  final faqs = <FaqModel>[].obs;

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

  void getFaqs() async {
    try {
      isLoading.value = true;
      final response = await ApiService.to.get(ApiConstants.homeFaqsEndpoint);

      log(response.toString());
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['faq_data'] ?? [];

        faqs.assignAll(data.map((item) => FaqModel.fromJson(item)).toList());
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

class Tabs {
  final String title;

  Tabs({required this.title});
}
