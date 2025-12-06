import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/routes/routes.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  final emailController = TextEditingController();

  void validateForm() {
    if (emailController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
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

  void onSendOtpTap() {
    validateForm();
  }

  void onSignUpTap() {
    Get.toNamed(Routes.register);
  }

  void onForgotEmailTap() {
    //
  }

  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
