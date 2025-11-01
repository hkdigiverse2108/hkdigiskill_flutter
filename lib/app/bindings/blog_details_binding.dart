import 'package:get/get.dart';
import 'package:hkdigiskill/modules/blog/controllers/blog_details_controller.dart';

class BlogDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BlogDetailsController());
  }
}
