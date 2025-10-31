import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/routes/routes.dart';

class OnboardingController extends GetxController {
  final RxInt currentStep = 0.obs;
  int totalSteps = 0;
  final storage = StorageService();

  @override
  void onInit() {
    totalSteps = onboardingData.length;
    super.onInit();
  }

  final List<OnboardingModel> onboardingData = [
    OnboardingModel(
      imagePath: AppImages.onboardingBackground,
      title: "Find your favorite class",
      description:
          "Discover a wide range of classes and find the perfect one for your interests and skill level.",
    ),
    OnboardingModel(
      imagePath: AppImages.onboardingBackground,
      // You can add more images as needed
      title: "Learn at your own pace",
      description:
          "Access courses anytime, anywhere and learn at a pace that suits you best.",
    ),
    OnboardingModel(
      imagePath: AppImages.onboardingBackground,
      // You can add more images as needed
      title: "Get certified",
      description:
          "Earn certificates upon courses completion to showcase your new skills.",
    ),
  ];

  void nextStep() {
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      // Navigate to home or login screen when onboarding is complete
      storage.seenOnboarding = true;
      Get.offAllNamed(Routes.login);
    }
  }

  void skipToEnd() {
    // Navigate to home or login screen
    storage.seenOnboarding = true;
    Get.offAllNamed(Routes.login);
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  bool get isLastStep => currentStep.value == totalSteps - 1;

  bool get isFirstStep => currentStep.value == 0;
}

class OnboardingModel {
  final String imagePath;
  final String title;
  final String description;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.description,
  });
}
