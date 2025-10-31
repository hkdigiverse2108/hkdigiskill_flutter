import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/routes/routes.dart';

class SplashController extends GetxController {
  // Example observable state
  var isLoading = true.obs;
  final storage = StorageService();

  // Initialize logic here
  @override
  void onInit() {
    super.onInit();
    // You can start animations, timers, API checks, etc. here
    _fakeLoading();
  }

  void _fakeLoading() async {
    await Future.delayed(Duration(seconds: 3));
    isLoading.value = false;
    if (storage.isLoggedIn) {
      Get.offAllNamed(Routes.navigation);
    } else if (storage.seenOnboarding) {
      Get.offAllNamed(Routes.login);
    } else {
      Get.offAllNamed(Routes.onboarding);
    }
    // Navigate or perform other actions after splash
  }
}
