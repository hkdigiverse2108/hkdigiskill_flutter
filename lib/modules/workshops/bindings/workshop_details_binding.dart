import 'package:get/get.dart';
import 'package:hkdigiskill/modules/workshops/controllers/workshop_details_controller.dart';

class WorkshopDetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WorkshopDetailsController>(() => WorkshopDetailsController());
  }
}
