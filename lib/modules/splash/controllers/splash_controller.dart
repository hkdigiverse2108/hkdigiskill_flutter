import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/payment_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/routes/routes.dart';

class SplashController extends GetxController {
  final storage = StorageService();

  @override
  void onInit() async {
    super.onInit();
    Future.microtask(() => _initSplash());
    // ✅ Initialize heavy services after first frame (non-blocking)
  }

  Future<void> _initSplash() async {
    final context = Get.context;
    if (context != null) {
      // ✅ Preload images to remove loading lag
      await Future.wait([
        precacheImage(AssetImage(AppImages.splashBackground), context),
        precacheImage(AssetImage(AppImages.logo), context),
      ]);
    }

    // Give animation some time to play
    await Future.delayed(const Duration(seconds: 3));

    // Navigate based on login state
    if (storage.isLoggedIn) {
      Get.offAllNamed(Routes.navigation);
    } else if (storage.seenOnboarding) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.onboarding);
    }
  }
}
