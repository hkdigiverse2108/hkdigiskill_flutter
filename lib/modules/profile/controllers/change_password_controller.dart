import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  // Track obscure text state for each password field
  final obscureOldPassword = true.obs;
  final obscureNewPassword = true.obs;
  final obscureConfirmPassword = true.obs;

  // Toggle methods for each password field
  void toggleOldPasswordVisibility() => obscureOldPassword.toggle();

  void toggleNewPasswordVisibility() => obscureNewPassword.toggle();

  void toggleConfirmPasswordVisibility() => obscureConfirmPassword.toggle();

  void updatePassword() async {
    try {
      isLoading.value = true;
      bool verify = validate();
      if (verify) {
        final res = await ApiService.to.post(
          ApiConstants.updatePassword,
          body: {
            "email": Globals.userData.value!.email,
            "oldPassword": oldPassCtrl.text,
            "newPassword": confirmPassCtrl.text,
          },
        );
        log(res.toString());
        if (res['status'] == 200) {
          Get.back();
          clear();
          AppSnackbar.success("Password updated successfully");
        }
      }
    } catch (e) {
      AppSnackbar.error("Something went wrong");
    } finally {
      isLoading.value = false;
    }
  }

  bool validate() {
    if (oldPassCtrl.text.isEmpty) {
      AppSnackbar.error("Old password is required");
      return false;
    } else if (newPassCtrl.text.isEmpty) {
      AppSnackbar.error("New password is required");
      return false;
    } else if (confirmPassCtrl.text.isEmpty) {
      AppSnackbar.error("Confirm password is required");
      return false;
    } else if (newPassCtrl.text != confirmPassCtrl.text) {
      AppSnackbar.error("Passwords do not match");
      return false;
    } else {
      return true;
    }
  }

  void clear() {
    oldPassCtrl.clear();
    newPassCtrl.clear();
    confirmPassCtrl.clear();
  }
}
