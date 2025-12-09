import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/models/banner/banner_model.dart';
import 'package:hkdigiskill/app/models/blog/blog_model.dart';
import 'package:hkdigiskill/app/models/categories/categories_model.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/navigation/controllers/navigation_controller.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class HomeController extends GetxController {
  final networkController = Get.find<NetworkController>();
  RxBool isLoading = true.obs;

  var isBennersLoading = true.obs;
  var isCategoriesLoading = true.obs;
  var isCoursesLoading = true.obs;
  var isBlogsLoading = true.obs;

  final navigationController = Get.find<NavigationController>();

  // Carousel images
  List<BannerModel> imageList = <BannerModel>[].obs;

  // Categories data
  final categories = <CategoriesModel>[].obs;

  // Popular courses data
  var courses = <CourseModel>[].obs;

  // Stats data
  final List<Map<String, dynamic>> counters = [
    {
      "count": "354+",
      "label": "TOP INSTRUCTORS",
      "color": Color(0xFFFFF4E6), // pale orange
      "textColor": Color(0xFFD17D2A),
    },
    {
      "count": "${Globals.appSettings?.satisfactionRate ?? 0}%",
      "label": "SATISFACTION RATE",
      "color": Color(0xFFF4F1FE), // pale purple
      "textColor": Color(0xFF7C44E6),
    },
    {
      "count": "${Globals.appSettings?.classCompleted ?? 0}",
      "label": "CLASS COMPLETED",
      "color": Color(0xFFFFF0F1), // pale red
      "textColor": Color(0xFFEB3E56),
    },
    {
      "count": "${Globals.appSettings?.enrolledLearners ?? 0}",
      "label": "STUDENT ENROLLED",
      "color": Color(0xFFE7FBFA), // pale teal
      "textColor": Color(0xFF10A69F),
    },
  ];

  // Blog posts data
  final List<BlogModel> blogs = <BlogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    navigationController.onInit();

    onBanners();
    onCategories();
    onCourses();
    onBlogs();
    onLoading();
  }

  void onBanners() async {
    try {
      isBennersLoading.value = true;
      if (!networkController.isConnected.value) {
        return;
      }
      final response = await ApiService.to.get(ApiConstants.bannersEndpoint);

      log(response.toString());
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['hero_banner_data'] ?? [];

        imageList.assignAll(
          data.map((item) => BannerModel.fromJson(item)).toList(),
        );
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isBennersLoading.value = false;
    }
  }

  void onCategories() async {
    try {
      isCategoriesLoading.value = true;

      if (!networkController.isConnected.value) {
        return;
      }

      final response = await ApiService.to.get(
        ApiConstants.homeCategoriesEndpoint,
      );

      log(response.toString());

      if (response['status'] == 200) {
        final List<dynamic> data =
            response['data']['course_category_data'] ?? [];

        categories.assignAll(
          data.map((item) => CategoriesModel.fromJson(item)).toList(),
        );

        await _loadCourseCountForCategories(); // <-- WAIT for completion
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<void> _loadCourseCountForCategories() async {
    for (int i = 0; i < categories.length; i++) {
      final category = categories[i];

      final res = await ApiService.to.get(
        '${ApiConstants.getCourseFromCategory}${category.id}',
      );

      if (res['status'] == 200) {
        final total = res['data']['totalData'] ?? 0;
        category.courseCount = total;
      }
    }

    categories.refresh();
  }

  void onCourses() async {
    try {
      isCoursesLoading.value = true;

      if (!networkController.isConnected.value) {
        return;
      }

      // Step 1: Fetch all courses
      final response = await ApiService.to.get(
        ApiConstants.homeCoursesEndpoint,
      );

      log(response.toString());

      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['course_data'] ?? [];

        courses.assignAll(
          data.map((item) => CourseModel.fromJson(item)).toList(),
        );

        // Step 2: Fetch rating for each course
        await _loadRatingsForCourses();
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isCoursesLoading.value = false;
    }
  }

  Future<void> _loadRatingsForCourses() async {
    for (int i = 0; i < courses.length; i++) {
      final course = courses[i];

      if (course.id == null) continue;

      final res = await ApiService.to.get(
        '${ApiConstants.ratingEndpoint}${course.id}',
      );

      log("Rating Response for ${course.id}: $res");

      if (res['status'] == 200) {
        final ratingData = res['data'];

        // Assign rating values
        course.averageRating = ratingData["averageRating"] ?? 0;
        course.totalRated = ratingData["totalRated"] ?? 0;
      }
    }

    // refresh UI
    courses.refresh();
  }

  void onBlogs() async {
    try {
      isBlogsLoading.value = true;
      if (!networkController.isConnected.value) {
        return;
      }
      final response = await ApiService.to.get(ApiConstants.homeBlogsEndpoint);

      log(response.toString());
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['blog_data'] ?? [];

        blogs.assignAll(data.map((item) => BlogModel.fromJson(item)).toList());
      }
    } catch (e) {
      log(e.toString());

      AppSnackbar.error("Something went wrong");
    } finally {
      isBlogsLoading.value = false;
    }
  }

  void onLoading() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      if (networkController.isConnected.value) {
        isLoading.value = false;
        update();
      } else {
        isLoading.value = true;
        update();
      }
    });
  }

  void onCourseViewAll() {
    navigationController.currentIndex.value = 2;
  }

  void onCategoryViewAll() {
    navigationController.currentIndex.value = 1;
  }

  void onBlogViewAll() {
    if (networkController.isConnected.value) {
      Get.toNamed(Routes.blogs);
    }
  }

  Future<void> onRefresh() async {
    try {
      await Future.wait(
        [onBanners(), onCategories(), onCourses(), onBlogs()]
            as Iterable<Future>,
      );
    } catch (e) {
      log('Error refreshing data: $e');
      rethrow;
    }
  }
}
