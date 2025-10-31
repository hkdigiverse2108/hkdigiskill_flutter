import 'package:get/get.dart';
import 'package:hkdigiskill/modules/otp_verify/controllers/otp_verify_controller.dart';

class OtpVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController());
  }
}
