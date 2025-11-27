import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/models/banner/banner_model.dart';
import 'package:hkdigiskill/app/models/blog/blog_model.dart';
import 'package:hkdigiskill/app/models/categories/categories_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/modules/navigation/controllers/navigation_controller.dart';
import 'package:hkdigiskill/routes/routes.dart';

class HomeController extends GetxController {
  final networkController = Get.find<NetworkController>();
  RxBool isLoading = true.obs;

  var isBennersLoading = false.obs;
  var isCategoriesLoading = false.obs;
  var isCoursesLoading = false.obs;
  var isBlogsLoading = false.obs;

  final navigationController = Get.find<NavigationController>();

  // Carousel images
  List<BannerModel> imageList = <BannerModel>[].obs;

  // Categories data
  final List<CategoriesModel> categories = [];

  // Popular courses data
  final List<Map<String, dynamic>> courses = [
    {
      "image":
          "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=500&q=80",
      "duration": "15 Weeks",
      "title": "Starting SEO as your Home Based Business",
      "rating": 5.0,
      "ratingCount": 3,
      "price": "\$30",
      "lessons": 11,
      "students": 227,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1465101162946-4377e57745c3?auto=format&fit=crop&w=500&q=80",
      "duration": "15 Weeks",
      "title": "Starting SEO as your Home Based Business",
      "rating": 5.0,
      "ratingCount": 3,
      "price": "\$30",
      "lessons": 11,
      "students": 227,
    },
  ];

  // Stats data
  final List<Map<String, dynamic>> counters = [
    {
      "count": "354+",
      "label": "TOP INSTRUCTORS",
      "color": Color(0xFFFFF4E6), // pale orange
      "textColor": Color(0xFFD17D2A),
    },
    {
      "count": "100%",
      "label": "SATISFACTION RATE",
      "color": Color(0xFFF4F1FE), // pale purple
      "textColor": Color(0xFF7C44E6),
    },
    {
      "count": "32.4K",
      "label": "CLASS COMPLETED",
      "color": Color(0xFFFFF0F1), // pale red
      "textColor": Color(0xFFEB3E56),
    },
    {
      "count": "29.3K",
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
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
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
      }
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCategoriesLoading.value = false;
    }
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
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
      );
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
    if (isLoading.value) {
    } else {
      Get.snackbar(
        'Error',
        'Please check your internet connection',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
