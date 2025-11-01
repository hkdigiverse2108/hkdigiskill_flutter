import 'package:get/get.dart';
import 'package:hkdigiskill/modules/courses/controllers/course_details_controller.dart';

class CourseDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CourseDetailsController>(() => CourseDetailsController());
  }
}
