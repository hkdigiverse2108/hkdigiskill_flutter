import 'package:get/get.dart';
import 'package:hkdigiskill/modules/faq/controllers/faq_controller.dart';

class FaqBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqController());
  }
}
