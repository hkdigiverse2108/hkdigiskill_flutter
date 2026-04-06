import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/themes/app_text_styles.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/modules/onboarding/controllers/onboarding_controller.dart';

class OnboardingScreen extends GetView<OnboardingController> {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currentData =
            controller.onboardingData[controller.currentStep.value];
        return Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(currentData.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     AppColors.primary.withValues(alpha: 0.6),
                    //     AppColors.primary,
                    //   ],
                    //   stops: const [0.4, 0.9],
                    // ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: AssetImage(AppImages.logo),
                    width: 200,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Text(
                      currentData.title,
                      style: AppTextStyles.headlineMedium,
                    ),
                    Gap(10),
                    Text(
                      currentData.description,
                      style: AppTextStyles.caption,
                      textAlign: TextAlign.center,
                    ),
                    Gap(20),
                    Expanded(
                      child: Center(
                        child: SizedBox(
                          height: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.totalSteps,
                              (index) => AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                ),
                                width: index == controller.currentStep.value
                                    ? 10
                                    : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  color: index == controller.currentStep.value
                                      ? AppColors.primary
                                      : AppColors.primary.withValues(alpha: 0.3),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Skip button
                        GestureDetector(
                          onTap: controller.isFirstStep
                              ? controller.skipToEnd
                              : controller.previousStep,
                          child: Text(
                            controller.isFirstStep ? 'Skip' : 'Previous',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),

                        // Arrow button
                        GestureDetector(
                          onTap: controller.nextStep,
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                controller.isLastStep
                                    ? Icons.check
                                    : Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
