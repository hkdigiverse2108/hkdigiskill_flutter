import 'package:get/get.dart';
import 'package:hkdigiskill/modules/chat/controllers/chats_controller.dart';

class ChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatsController>(() => ChatsController());
  }
}
