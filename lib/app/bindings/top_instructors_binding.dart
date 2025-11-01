import 'package:get/get.dart';
import 'package:hkdigiskill/modules/instructor/controllers/instructor_controller.dart';

class TopInstructorsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InstructorController());
  }
}
