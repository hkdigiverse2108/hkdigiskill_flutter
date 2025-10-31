import 'package:get/get.dart';
import 'package:hkdigiskill/modules/category/controllers/category_controller.dart';
import 'package:hkdigiskill/modules/courses/controllers/courses_controller.dart';
import 'package:hkdigiskill/modules/home/controllers/home_controller.dart';
import 'package:hkdigiskill/modules/navigation/controllers/navigation_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CoursesController>(() => CoursesController());
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
