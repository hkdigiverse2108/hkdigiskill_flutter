import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class SignUpController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final designationController = TextEditingController();
  final referralCodeController = TextEditingController();
  final obscurePassword = true.obs;

  var isAgree = false.obs;

  var isLoading = false.obs;

  void onAgreeChanged(bool value) {
    isAgree.value = value;
  }

  void onSignUpTap() {
    validateForm();
  }

  void onSignInTap() {
    Get.back();
  }

  void onTermsTap() {
    // Get.toNamed(Routes.terms);
  }

  void validateForm() {
    if (fullNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        phoneNumberController.text.isEmpty ||
        designationController.text.isEmpty) {
      AppSnackbar.error('Please fill in all fields', title: 'Validation Error');
    } else if (!emailController.text.isValidEmail()) {
      AppSnackbar.error(
        'Please enter a valid email',
        title: 'Validation Error',
      );
    } else if (passwordController.text.length < 8) {
      AppSnackbar.error(
        'Password must be at least 8 characters',
        title: 'Validation Error',
      );
    } else if (phoneNumberController.text.length < 10) {
      AppSnackbar.error(
        'Phone number must be at least 10 characters',
        title: 'Validation Error',
      );
    } else {
      callApi();
    }
  }

  void callApi() async {
    try {
      isLoading.value = true;
      final res = await ApiService.to.post(
        ApiConstants.registerEndpoint,
        body: {
          "fullName": fullNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "phoneNumber": phoneNumberController.text,
          "designation": designationController.text,
          if (referralCodeController.text.isNotEmpty)
            "referralCode": referralCodeController.text,
          "agreeTerms": isAgree.value,
          // todo: add referral code
        },
      );

      log("Url: ${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}");
      log(res.toString());

      if (res['status'] == 200) {
        Get.back();
        AppSnackbar.success('User registered successfully');
      } else {
        AppSnackbar.error(res['message'] ?? 'An error occurred');
      }
    } on Exception catch (e) {
      AppSnackbar.error(e.toString().replaceFirst('Exception: ', ''));
    } catch (e) {
      AppSnackbar.error('Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneNumberController.dispose();
    designationController.dispose();
    referralCodeController.dispose();
    super.onClose();
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(this);
  }
}
