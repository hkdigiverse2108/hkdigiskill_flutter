import 'package:get/get.dart';
import 'package:hkdigiskill/modules/testimonials/controllers/testimonials_controller.dart';

class TestimonialsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TestimonialsController>(() => TestimonialsController());
  }
}
