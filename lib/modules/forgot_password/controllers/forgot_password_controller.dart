import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();

  void validateForm() {
    if (emailController.text.isEmpty) {
      AppSnackbar.error("Email is required");
    } else if (!GetUtils.isEmail(emailController.text)) {
      AppSnackbar.error("Invalid Email", title: "Validation Error");
    } else {
      callApi();
    }
  }

  void callApi() async {
    try {
      isLoading.value = true;

      final res = await ApiService.to.post(
        "/auth/forgot-password",
        body: {"email": emailController.text},
      );

      if (res['status'] == 200) {
        Get.toNamed(
          Routes.otpVerify,
          arguments: {'email': emailController.text},
        );
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  void onSendOtpTap() {
    validateForm();
  }

  void onSignUpTap() {
    Get.toNamed(Routes.register);
  }

  void onForgotEmailTap() {
    Get.toNamed(Routes.contactUs);
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
