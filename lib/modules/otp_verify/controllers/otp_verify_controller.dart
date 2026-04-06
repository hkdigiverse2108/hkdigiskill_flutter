import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/user/user_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class OtpVerifyController extends GetxController {
  var isLoading = false.obs;
  var isResendLoading = false.obs;
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
    isLogin.value ? onResendOtp() : null;
    super.onInit();
  }

  @override
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

  void onResendOtp() async {
    try {
      isResendLoading.value = true;
      final res = await ApiService.to.post(
        ApiConstants.resendOtpEndpoint,
        body: {"email": email},
      );
      if (res['status'] == 200) {
        resetCountDown();
      } else {
        AppSnackbar.error(res['message']);
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isResendLoading.value = false;
    }
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
      AppSnackbar.error("OTP is required", title: "Validation Error");
    } else {
      callApi();
    }
  }

  void callApi() async {
    try {
      isLoading.value = true;
      final res = await ApiService.to.post(
        ApiConstants.verifyOtpEndpoint,
        body: {"email": email, "otp": otpController.text},
      );

      if (res['status'] == 200) {
        if (isLogin.value) {
          getUserData(res['data']['_id']);
        } else {
          Get.toNamed(Routes.newPassword, arguments: {'email': email});
        }
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong, Check your OTP");
    } finally {
      isLoading.value = false;
    }
  }

  void onVerifyTap() {
    validateForm();
  }

  Future<void> getUserData(String id) async {
    try {
      isLoading.value = true;
      final res = await ApiService.to.get(ApiConstants.getUserEndpoint + id);
      if (res['status'] == 200) {
        storage.userData = res['data'];
        Globals.userData.value = UserModel.fromJson(res['data']);
        storage.isLoggedIn = true;
        Get.offAllNamed(Routes.navigation);
      }
    } catch (e) {
      log(e.toString());
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }
}
