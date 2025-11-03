import 'package:get/get.dart';
import 'package:hkdigiskill/modules/app_info/controllers/contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactUsController());
  }
}
