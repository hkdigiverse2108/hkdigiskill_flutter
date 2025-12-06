import 'dart:developer';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';

class CoursesController extends GetxController {
  final networkController = Get.find<NetworkController>();

  final isLoading = false.obs;
  final courses = <CourseModel>[].obs;
  final myCourse = <CourseModel>[].obs;

  final isFilterMode = false.obs;
  String? categoryId;

  @override
  void onInit() {
    isFilterMode.value = Get.arguments?['isFilterMode'] ?? false;
    categoryId = Get.arguments?['categoryId'];

    super.onInit();
    fetchCourses();
  }

  Future<void> fetchCourses() async {
    try {
      isLoading.value = true;

      if (!networkController.isConnected.value) {
        Get.snackbar(
          'Error',
          'No internet connection',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      /// API URL
      final endpoint = categoryId != null
          ? '${ApiConstants.getCourseFromCategory}$categoryId'
          : ApiConstants.coursesEndpoint;

      final response = await ApiService.to.get(endpoint);
      log('Courses API Response: $response');

      if (response['status'] == 200) {
        final List rawData = response['data']['course_data'] ?? [];

        /// convert to model
        courses.assignAll(rawData.map((e) => CourseModel.fromJson(e)).toList());

        /// split unlocked courses
        splitPurchasedFromAll();

        /// load ratings now
        await _loadRatingsForCourses();
      } else {
        Get.snackbar('Error', 'Failed to load courses');
      }
    } catch (e) {
      log('Error fetching courses: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// SPLIT UNLOCKED / PURCHASED
  void splitPurchasedFromAll() {
    final purchased = <CourseModel>[];

    for (final c in courses) {
      if (c.isUnlocked == true) {
        purchased.add(c);
      }
    }

    /// set purchased
    myCourse.assignAll(purchased);

    /// remove them from courses list
    courses.removeWhere((c) => c.isUnlocked == true);

    courses.refresh();
    myCourse.refresh();

    log("Unlocked courses: ${myCourse.length}");
    log("Locked courses: ${courses.length}");
  }

  /// LOAD RATINGS
  Future<void> _loadRatingsForCourses() async {
    for (int i = 0; i < courses.length; i++) {
      final course = courses[i];
      if (course.id == null) continue;

      final res = await ApiService.to.get(
        '${ApiConstants.ratingEndpoint}${course.id}',
      );

      if (res['status'] == 200) {
        final data = res['data'];

        course.averageRating = data["averageRating"] ?? 0;
        course.totalRated = data["totalRated"] ?? 0;
      }
    }

    courses.refresh();
  }

  /// Refresh manually
  void onRefresh() {
    fetchCourses();
  }
}
