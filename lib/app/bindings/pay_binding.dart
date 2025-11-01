import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/pay_controller.dart';

class PayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PayController());
  }
}
