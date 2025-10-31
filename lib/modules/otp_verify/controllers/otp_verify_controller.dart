import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/routes/routes.dart';

class OtpVerifyController extends GetxController {
  var isLoading = false.obs;
  var isLogin = false.obs;
  String? email;
  final otpController = TextEditingController();
  var isResendOtp = false.obs;
  var countDownCount = 0.obs;

  var countDown = 30.obs;
  var isCountDown = false.obs;
  var isMoreThenThereTime = false.obs;
  final storage = StorageService();

  @override
  void onInit() {
    isLogin.value = Get.arguments['isLogin'] ?? false;
    email = Get.arguments['email'];
    startCountDown();
    super.onInit();
  }

  void onClose() {
    otpController.dispose();
    super.onClose();
  }

  void startCountDown() {
    isCountDown.value = true;
    countDown.value = 30;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countDown.value > 0) {
        countDown.value--;
      } else {
        isCountDown.value = false;
        timer.cancel();
      }
    });
  }

  void resetCountDown() {
    if (countDownCount.value >= 3) {
      isMoreThenThereTime.value = true;
    } else {
      countDownCount.value++;
      isCountDown.value = false;
      startCountDown();
    }
  }

  void validateForm() {
    if (otpController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      if (isLogin.value) {
        storage.isLoggedIn = true;
        Get.offAllNamed(Routes.navigation);
      } else {
        Get.toNamed(Routes.newPassword);
      }
    }
  }

  void onVerifyTap() {
    validateForm();
  }
}
