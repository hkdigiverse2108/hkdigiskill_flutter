import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';
import 'package:hkdigiskill/app/models/curriculum/curriculum_model.dart';
import 'package:hkdigiskill/app/models/faq/faq_model.dart';
import 'package:hkdigiskill/app/models/lesson/lesson_model.dart';
import 'package:hkdigiskill/app/models/testimonial/testimonial_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';

class CourseDetailsController extends GetxController {
  final selectedTab = 0.obs;
  var isPurchased = false.obs;
  var isLoading = false.obs;
  var isTestimonialsLoading = false.obs;
  var isLessonsLoading = false.obs;
  var isFaqsLoading = false.obs;
  var curriculumList = <CurriculumModel>[].obs;
  var isCurriculumLoading = false.obs;
  var courseId = "";
  var isCourseRatingLoading = false.obs;
  var course = CourseModel().obs;
  var testimonials = <TestimonialModel>[].obs;
  var lessons = <LessonModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    course.value = Get.arguments;
    courseId = course.value.id ?? "";
    getCourseDetails();
    getTestimonials();
    getCourseRating();
    getFaqs();
    getLessonsAndCurriculum();
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

  Future<void> getCourseDetails() async {
    try {
      isLoading.value = true;
      final response = await ApiService.to.get(
        '${ApiConstants.courseByIdEndpoint}/$courseId',
      );

      if (response['status'] == 200 && response['data'] != null) {
        course.value = CourseModel.fromJson(response['data']);
      } else {
        throw Exception('Failed to load course details');
      }
    } catch (e) {
      log('Error fetching course details: $e');
      Get.snackbar(
        'Error',
        'Failed to load course details',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void getFaqs() async {
    try {
      isFaqsLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.getFaqsByCourseIdEndpoint(courseId),
      );

      log(ApiConstants.getFaqsByCourseIdEndpoint(courseId));
      log("Data: $response");
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['faq_data'] ?? [];
        faqs.assignAll(data.map((item) => FaqModel.fromJson(item)).toList());

        log("Faqs: ${faqs.length}");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load FAQs',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isFaqsLoading.value = false;
    }
  }

  void getTestimonials() async {
    try {
      isTestimonialsLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.getTestimonialsByCourseIdEndpoint(courseId),
      );

      log(ApiConstants.getTestimonialsByCourseIdEndpoint(courseId));
      log("Data: $response");
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['testimonial_data'] ?? [];
        testimonials.assignAll(
          data.map((item) => TestimonialModel.fromJson(item)).toList(),
        );

        log("Testimonials: ${testimonials.length}");
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load testimonials',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isTestimonialsLoading.value = false;
    }
  }

  Future<void> getLessonsAndCurriculum() async {
    try {
      isLessonsLoading.value = true;

      final response = await ApiService.to.get(
        ApiConstants.courseLessonsEndpoint + courseId,
      );

      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['course_lesson_data'] ?? [];

        // Parse lessons
        lessons.assignAll(
          data.map((item) => LessonModel.fromJson(item)).toList(),
        );

        // Sort lessons by priority (0 → 1 → 2 → 3...)
        lessons.sort((a, b) => a.priority.compareTo(b.priority));

        log("Sorted Lessons: ${lessons.length}");

        // 👉 Fetch curriculum for each lesson individually
        await getCurriculum();
      }
    } catch (e) {
      log("Error fetching lessons and curriculum: $e");
    } finally {
      isLessonsLoading.value = false;
    }
  }

  Future<void> getCurriculum() async {
    try {
      isCurriculumLoading.value = true;

      for (var lesson in lessons) {
        lesson.curriculum = []; // reset
      }

      for (var lesson in lessons) {
        final lessonId = lesson.id;
        if (lessonId.isEmpty) continue;

        final response = await ApiService.to.get(
          '${ApiConstants.getCurriculumEndpoint}$lessonId',
        );

        if (response['status'] == 200) {
          final List<dynamic> data =
              response['data']['course_curriculum_data'] ?? [];

          final parsed = data
              .map((item) => CurriculumModel.fromJson(item))
              .toList();

          /// 🔥 Attach curriculum to that specific lesson
          lesson.curriculum = parsed;
        }
      }

      lessons.refresh(); // 🔥 Required so UI updates
    } finally {
      isCurriculumLoading.value = false;
    }
  }

  void changeTab(int index) {
    selectedTab.value = index;
  }

  getCourseRating() async {
    try {
      isCourseRatingLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.ratingEndpoint + courseId,
      );

      log("Rating for Workshop $courseId: $response");

      if (response['status'] == 200) {
        final data = response['data'];

        course.value.averageRating = data["averageRating"] ?? 0;
        course.value.totalRated = data["totalRated"] ?? 0;
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Failed to load workshop rating',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCourseRatingLoading.value = false;
    }
  }
}

class Tabs {
  final String title;

  Tabs({required this.title});
}
