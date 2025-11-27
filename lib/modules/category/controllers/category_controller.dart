import 'dart:developer';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/models/categories/categories_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/routes/routes.dart';

class CategoryController extends GetxController {
  final networkController = Get.find<NetworkController>();
  RxBool isLoading = true.obs;

  final List<CategoriesModel> items = <CategoriesModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    onCategories();
  }

  void onItemTap({required id}) {
    Get.toNamed(Routes.courses, arguments: true);
  }

  void onCategories() async {
    try {
      isLoading.value = true;
      if (!networkController.isConnected.value) {
        return;
      }
      final response = await ApiService.to.get(ApiConstants.categoriesEndpoint);

      log(response.toString());
      if (response['status'] == 200) {
        final List<dynamic> data =
            response['data']['course_category_data'] ?? [];

        items.assignAll(
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
      isLoading.value = false;
    }
  }
}
