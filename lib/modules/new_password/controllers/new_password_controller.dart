import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/routes/routes.dart';

class NewPasswordController extends GetxController {
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void onSetNewPasswordTap() {
    Get.offAllNamed(Routes.login);
  }

  void onNeedHelpTap() {
    // Add your help functionality here
    // For example:
    // Get.toNamed(Routes.HELP_SCREEN);
    // or show a dialog
    Get.snackbar('Help', 'Contact support for assistance');
  }
}
