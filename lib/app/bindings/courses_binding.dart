import 'package:get/get.dart';
import 'package:hkdigiskill/modules/courses/controllers/courses_controller.dart';

class CoursesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CoursesController>(() => CoursesController());
  }
}
