import 'dart:ui';

import 'package:get/get.dart';
import 'package:hkdigiskill/routes/routes.dart';

class CategoryController extends GetxController {
  RxBool isLoading = true.obs;

  final List<Map<String, dynamic>> items = List.generate(
    4,
    (i) => {
      "title": "Business Development",
      "count": "16 Course",
      "description":
          "Your AI learning journey begins today.Your AI learning journey begins today. Your AI learning journey begins",
      "bgColor": Color(0xFFFDE7E3),
    },
  );

  @override
  void onInit() {
    super.onInit();
    onLoading();
  }

  void onItemTap({required id}) {
    Get.toNamed(Routes.courses, arguments: true);
  }

  void onLoading() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 5), () {
      isLoading.value = false;
      update();
    });
  }
}
