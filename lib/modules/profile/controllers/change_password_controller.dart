import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';

class ChangePasswordController extends GetxController {
  var isLoading = false.obs;

  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  void updatePassword() async {
    try {
      isLoading.value = true;
      bool verify = validate();
      if (verify) {
        final res = await ApiService.to.post(
          ApiConstants.ratingEndpoint,
          body: {
            "email": Globals.userData!.email,
            "oldPassword": oldPassCtrl.text,
            "newPassword": newPassCtrl.text,
          },
        );
        if (res.statusCode == 200) {
          Get.snackbar(
            "Success",
            "Password updated successfully",
            snackPosition: SnackPosition.BOTTOM,
          );
          clear();
        }
      } else {
        return;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  bool validate() {
    if (oldPassCtrl.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Old password is required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (newPassCtrl.text.isEmpty) {
      Get.snackbar(
        "Error",
        "New password is required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (confirmPassCtrl.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Confirm password is required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } else if (newPassCtrl.text != confirmPassCtrl.text) {
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

  void clear() {
    oldPassCtrl.clear();
    newPassCtrl.clear();
    confirmPassCtrl.clear();
  }
}
