import 'package:get/get.dart';
import 'package:hkdigiskill/modules/blog/controllers/blog_controller.dart';

class BlogBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BlogController());
  }
}
