import 'dart:developer';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/instructor/instructor_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class InstructorController extends GetxController {
  var instructors = <InstructorModel>[].obs;

  // controls which instructor's icons are shown
  var showIcons = <RxBool>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    onInstructors();
    super.onInit();
  }

  void onInstructors() async {
    try {
      isLoading.value = true;
      final response = await ApiService.to.get(
        ApiConstants.instructorsEndpoint,
      );

      log(response.toString());
      if (response['status'] == 200) {
        final List<dynamic> data = response['data']['instructor_data'] ?? [];

        instructors.assignAll(
          data.map((item) => InstructorModel.fromJson(item)).toList(),
        );

        showIcons.value = List.generate(instructors.length, (_) => false.obs);
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void toggleIcons(int index) {
    // Hide others, toggle current
    for (int i = 0; i < showIcons.length; i++) {
      showIcons[i].value = i == index ? !showIcons[i].value : false;
    }
  }
}
