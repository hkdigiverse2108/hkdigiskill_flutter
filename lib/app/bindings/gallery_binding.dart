import 'package:get/get.dart';
import 'package:hkdigiskill/modules/gallery/controllers/gallery_controller.dart';

class GalleryBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GalleryController());
  }
}
