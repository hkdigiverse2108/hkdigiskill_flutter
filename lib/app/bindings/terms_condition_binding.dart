import 'package:get/get.dart';
import 'package:hkdigiskill/modules/app_info/controllers/terms_condition_controller.dart';

class TermsConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsConditionController());
  }
}
