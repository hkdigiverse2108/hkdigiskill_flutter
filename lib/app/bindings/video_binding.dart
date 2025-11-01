import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VideoController());
  }
}
