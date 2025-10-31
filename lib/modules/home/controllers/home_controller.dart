import 'dart:ui';

import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/navigation/controllers/navigation_controller.dart';

class HomeController extends GetxController {
  final navigationController = Get.find<NavigationController>();

  // Carousel images
  final List<String> imageList = [
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1465101162946-4377e57745c3?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1454023492550-5696f8ff10e1?auto=format&fit=crop&w=400&q=80',
  ];

  // Categories data
  final List<Map<String, dynamic>> categories = [
    {
      'count': '16',
      'title': 'Course',
      'subtitle': 'Business Develop',
      'color': Color(0xFFD17D2A), // orange
    },
    {
      'count': '12',
      'title': 'Course',
      'subtitle': 'Completeness',
      'color': AppColors.primary,
    },
    {
      'count': '10',
      'title': 'Course',
      'subtitle': 'Assigments',
      'color': AppColors.info,
    },
    {
      'count': '12',
      'title': 'Course',
      'subtitle': 'Total Subject',
      'color': Color(0xFFD17D2A), // orange
    },
  ];

  // Popular courses data
  final List<Map<String, dynamic>> courses = [
    {
      "image":
          "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=500&q=80",
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
          "https://images.unsplash.com/photo-1465101162946-4377e57745c3?auto=format&fit=crop&w=500&q=80",
      "duration": "15 Weeks",
      "title": "Starting SEO as your Home Based Business",
      "rating": 5.0,
      "ratingCount": 3,
      "price": "\$30",
      "lessons": 11,
      "students": 227,
    },
  ];

  // Stats data
  final List<Map<String, dynamic>> counters = [
    {
      "count": "354+",
      "label": "TOP INSTRUCTORS",
      "color": Color(0xFFFFF4E6), // pale orange
      "textColor": Color(0xFFD17D2A),
    },
    {
      "count": "100%",
      "label": "SATISFACTION RATE",
      "color": Color(0xFFF4F1FE), // pale purple
      "textColor": Color(0xFF7C44E6),
    },
    {
      "count": "32.4K",
      "label": "CLASS COMPLETED",
      "color": Color(0xFFFFF0F1), // pale red
      "textColor": Color(0xFFEB3E56),
    },
    {
      "count": "29.3K",
      "label": "STUDENT ENROLLED",
      "color": Color(0xFFE7FBFA), // pale teal
      "textColor": Color(0xFF10A69F),
    },
  ];

  // Blog posts data
  final List<Map<String, dynamic>> blogs = [
    {
      "image":
          "https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80",
      "category": "SCIENCE",
      "title": "Crafting Effective Learning Guide Line",
      "date": "16 Nov, 2023",
      "comments": 0,
      "excerpt": "Consectetur adipisicing elit, sed do eiusmod tempor inc...",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1465101162946-4377e57745c3?auto=format&fit=crop&w=400&q=80",
      "category": "SCIENCE",
      "title": "Crafting Effective Learning Guide Line",
      "date": "16 Nov, 2023",
      "comments": 0,
      "excerpt": "Consectetur adipisicing elit, sed do eiusmod tempor inc...",
    },
    {
      "image":
          "https://images.unsplash.com/photo-1454023492550-5696f8ff10e1?auto=format&fit=crop&w=400&q=80",
      "category": "SCIENCE",
      "title": "Crafting Effective Learning Guide Line",
      "date": "16 Nov, 2023",
      "comments": 0,
      "excerpt": "Consectetur adipisicing elit, sed do eiusmod tempor inc...",
    },
  ];

  @override
  void onInit() {
    super.onInit();
    navigationController.onInit();
  }

  void onCourseViewAll() {
    navigationController.currentIndex.value = 2;
  }
}
