import 'package:get/get.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsController extends GetxController {
  /// EMAIL
  Future<void> openEmail() async {
    final email = Globals.appSettings?.email ?? "";
    final subject = Uri.encodeComponent("Support request");
    final body = Uri.encodeComponent("Hello, I need help with...");

    final url = Uri.parse("mailto:$email?subject=$subject&body=$body");

    if (!await launchUrl(url)) {
      Get.snackbar("Error", "Could not open email");
    }
  }

  /// WHATSAPP
  Future<void> openWhatsApp() async {
    final phone = "+91${Globals.appSettings?.phoneNumber ?? ""}";
    const message = "Hello! I need help."; // Change

    final url = Uri.parse(
      "https://wa.me/$phone?text=${Uri.encodeComponent(message)}",
    );

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.snackbar("Error", "Could not open WhatsApp");
    }
  }

  /// Support webpage
  Future<void> openSupport() async {
    final url = Globals.appSettings?.link ?? "";

    if (!await launchUrl(Uri.parse(url))) {
      Get.snackbar("Error", "Could not open support page");
    }
  }
}
