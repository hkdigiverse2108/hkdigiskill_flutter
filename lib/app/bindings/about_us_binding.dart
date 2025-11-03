import 'package:get/get.dart';
import 'package:hkdigiskill/modules/app_info/controllers/about_us_controller.dart';

class AboutUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutUsController());
  }
}
