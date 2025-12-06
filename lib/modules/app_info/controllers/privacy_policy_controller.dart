import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';

class PrivacyPolicyController extends GetxController {
  final isLoading = false.obs;

  var content = "".obs;

  @override
  void onInit() {
    super.onInit();
    getPrivacyPolicyContent();
  }

  void getPrivacyPolicyContent() async {
    try {
      isLoading.value = true;

      final response = await ApiService.to.get(
        ApiConstants.privacyPolicyEndpoint,
      );

      if (response['status'] == 200) {
        content.value = response['data']['content'];
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
