import 'dart:ui';

import 'package:get/get.dart';

class CategoryController extends GetxController {
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
}
