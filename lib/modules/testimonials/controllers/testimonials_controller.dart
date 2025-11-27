import 'dart:developer';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/testimonial/testimonial_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';

class TestimonialsController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getTestimonials();
  }

  final List<TestimonialModel> testimonials = <TestimonialModel>[].obs;

  void getTestimonials() async {
    try {
      isLoading.value = true;
      var response = await ApiService.to.get(ApiConstants.testimonialsEndpoint);

      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['testimonial_data'] ?? [];

        testimonials.assignAll(
          data.map((item) => TestimonialModel.fromJson(item)).toList(),
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
