import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/user/user_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  final storage = StorageService();

  void onLoginTap() {
    validateForm();
  }

  void onSignUpTap() {
    Get.toNamed(Routes.register);
  }

  void onForgotPasswordTap() {
    Get.toNamed(Routes.forgotPassword);
  }

  void validateForm() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
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
        ApiConstants.loginEndpoint,
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      if (res['status'] == 200) {
        if (res['data']['role'] == "admin") {
          Get.snackbar(
            'Admin Login detected!',
            "You can not login with admin credentials in the user section",
            snackPosition: SnackPosition.BOTTOM,
          );
          return;
        }

        storage.token = res['data']['token'];
        storage.isLoggedIn = true;

        Get.toNamed(
          Routes.otpVerify,
          arguments: {'isLogin': true, 'email': emailController.text},
        );
        Get.snackbar(
          'OTP',
          'OTP sent to ${emailController.text}',
          snackPosition: SnackPosition.BOTTOM,
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
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
