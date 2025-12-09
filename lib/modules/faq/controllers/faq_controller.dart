import 'dart:developer';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/faq/faq_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class FaqController extends GetxController {
  var faqs = <FaqModel>[].obs;
  var isLoading = false.obs;

  void onInit() {
    super.onInit();
    getFaqs();
  }

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
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
