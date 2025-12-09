import 'dart:developer';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/blog/blog_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class BlogController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<BlogModel> blogs = <BlogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    onBlogs();
  }

  void onBlogs() async {
    try {
      isLoading.value = true;
      final response = await ApiService.to.get(ApiConstants.blogsEndpoint);

      log(response.toString());
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['blog_data'] ?? [];

        blogs.assignAll(data.map((item) => BlogModel.fromJson(item)).toList());
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
