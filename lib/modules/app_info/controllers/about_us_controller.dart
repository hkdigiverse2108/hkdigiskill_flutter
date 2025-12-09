import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/shared/widgets/app_snackbar.dart';

class AboutUsController extends GetxController {
  final isLoading = false.obs;

  var content = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAboutUsContent();
  }

  void getAboutUsContent() async {
    try {
      isLoading.value = true;

      final response = await ApiService.to.get(ApiConstants.aboutUsEndpoint);

      if (response['status'] == 200) {
        content.value = response['data']['aboutUs'];
      }
    } catch (e) {
      AppSnackbar.error("Try After Some Time..");
    } finally {
      isLoading.value = false;
    }
  }
}
