import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/navigation/controllers/navigation_controller.dart';
import 'package:hkdigiskill/shared/widgets/custom_bottom_navbar.dart';

class Navigation extends GetView<NavigationController> {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          transitionBuilder: (Widget child, Animation<double> animation) {
            // Fade + Slide, you can customize
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.05, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: controller.pages[controller.currentIndex.value],
        );
      }),
      bottomNavigationBar: Obx(
        () => CustomBottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: (int value) {
            if (value == 4) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.construction_rounded,
                            size: 48,
                            color: AppColors.caption,
                          ),
                          const SizedBox(height: 16),

                          const Text(
                            "Coming Soon",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),

                          const Text(
                            "We're still working on this feature. Check other sections for now!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black54,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Text(
                                  "Got it 👍",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              controller.changePage(value);
            }
          },
        ),
      ),
    );
  }
}
