import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            controller.changePage(value);
          },
        ),
      ),
    );
  }
}
