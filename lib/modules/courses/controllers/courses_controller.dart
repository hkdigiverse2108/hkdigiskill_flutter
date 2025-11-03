import 'package:get/get.dart';

class CoursesController extends GetxController {
  final isFilterMode = false.obs;

  @override
  void onInit() {
    isFilterMode.value = Get.arguments ?? false;
    super.onInit();
  }

  final List<Map<String, dynamic>> courses = [
    {
      "image":
          "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80",
      "duration": "15 Weeks",
      "title": "Starting SEO as your Home Based Business",
      "rating": 5.0,
      "ratingCount": 3,
      "price": "\$30",
      "lessons": 11,
      "students": 227,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1465101162946-4377e57745c3?auto=format&fit=crop&w=400&q=80",
      "duration": "15 Weeks",
      "title": "Starting SEO as your Home Based Business",
      "rating": 5.0,
      "ratingCount": 3,
      "price": "\$30",
      "lessons": 11,
      "students": 227,
    },
    {
      "image":
          "https://images.unsplash.com/photo-1454023492550-5696f8ff10e1?auto=format&fit=crop&w=400&q=80",
      "duration": "15 Weeks",
      "title": "Starting SEO as your Home Based Business",
      "rating": 5.0,
      "ratingCount": 3,
      "price": "\$30",
      "lessons": 11,
      "students": 227,
    },
  ];
}
