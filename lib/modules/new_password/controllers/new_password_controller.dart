import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

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
      AppSnackbar.error("New password is required");
      return false;
    } else if (confirmPasswordController.text.isEmpty) {
      AppSnackbar.error("Confirm password is required");
      return false;
    } else if (newPasswordController.text != confirmPasswordController.text) {
      AppSnackbar.error("Passwords do not match");
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
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void onNeedHelpTap() {
    Get.toNamed(Routes.contactUs);
  }
}
