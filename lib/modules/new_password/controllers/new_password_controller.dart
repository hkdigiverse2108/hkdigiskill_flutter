import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/routes/routes.dart';

class NewPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;

  var email = "";

  @override
  onInit() {
    super.onInit();
    email = Get.arguments['email'];
  }

  bool validate() {
    if (newPasswordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "New password is required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Confirm password is required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar(
        "Error",
        "New password and confirm password do not match",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else {
      return true;
    }
  }

  void onSetNewPasswordTap() {
    if (validate()) {
      callApi();
    }
  }

  void callApi() async {
    try {
      isLoading.value = true;

      final res = await ApiService.to.post(
        "/auth/reset-password",
        body: {"newPassword": newPasswordController.text, "email": email},
      );

      if (res['status'] == 200) {
        Get.offAllNamed(Routes.login);
      } else {
        Get.snackbar(
          'Error',
          res['message'],
          snackPosition: SnackPosition.BOTTOM,
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

  void onNeedHelpTap() {
    Get.snackbar('Help', 'Contact support for assistance');
  }
}
