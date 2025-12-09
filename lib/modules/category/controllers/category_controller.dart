import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/models/categories/categories_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class CategoryController extends GetxController {
  final networkController = Get.find<NetworkController>();
  RxBool isLoading = true.obs;

  final items = <CategoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    onCategories();
  }

  void onItemTap({required id}) {
    Get.toNamed(
      Routes.courses,
      arguments: {'isFilterMode': true, 'categoryId': id},
    );
  }

  void onCategories() async {
    try {
      isLoading.value = true;

      if (!networkController.isConnected.value) {
        return;
      }

      // Step 1: Fetch all categories
      final response = await ApiService.to.get(ApiConstants.categoriesEndpoint);

      if (response['status'] == 200) {
        final List<dynamic> data =
            response['data']['course_category_data'] ?? [];

        // Parse categories
        items.assignAll(
          data.map((item) => CategoriesModel.fromJson(item)).toList(),
        );

        // Step 2: For each category, fetch course count
        await _loadCourseCountForCategories();
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _loadCourseCountForCategories() async {
    for (int i = 0; i < items.length; i++) {
      final category = items[i];

      final res = await ApiService.to.get(
        '${ApiConstants.getCourseFromCategory}${category.id}',
      );

      if (res['status'] == 200) {
        final total = res['data']['totalData'] ?? 0;
        category.courseCount = total;
      }
    }

    items.refresh();
  }
}
