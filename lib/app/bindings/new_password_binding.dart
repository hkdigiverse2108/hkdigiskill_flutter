import 'package:get/get.dart';
import 'package:hkdigiskill/modules/new_password/controllers/new_password_controller.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewPasswordController>(() => NewPasswordController());
  }
}
