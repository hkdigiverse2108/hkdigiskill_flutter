import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/user/user_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class SignInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var isPasswordVisible = false.obs;

  var isLoading = false.obs;
  final storage = StorageService();

  void onLoginTap() {
    validateForm();
  }

  void onSignUpTap() {
    emailController.clear();
    passwordController.clear();
    Get.toNamed(Routes.register);
  }

  void onForgotPasswordTap() {
    Get.toNamed(Routes.forgotPassword);
  }

  void validateForm() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      AppSnackbar.error('Please fill in all fields', title: 'Validation Error');
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
          AppSnackbar.error(
            "You can not login with admin credentials in the user section",
          );
          isLoading.value = false;
          return;
        }

        storage.token = res['data']['token'];

        Get.toNamed(
          Routes.otpVerify,
          arguments: {'isLogin': true, 'email': emailController.text},
        );
        AppSnackbar.info('OTP sent to ${emailController.text}');
      } else {
        AppSnackbar.error(res['message']);
      }
    } on SocketException {
      AppSnackbar.error("No internet connection", title: "Network Error");
    } catch (e) {
      AppSnackbar.error("Login failed, please try again");
    } finally {
      isLoading.value = false;
    }
  }
}
