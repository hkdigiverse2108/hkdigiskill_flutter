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
        return controller.pages[controller.currentIndex.value];
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
