import 'package:get/get.dart';
import 'package:hkdigiskill/modules/workshops/controllers/workshops_controller.dart';

class WorkshopsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkshopsController>(() => WorkshopsController());
  }
}
