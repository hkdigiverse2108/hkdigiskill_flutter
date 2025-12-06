import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialLinkHelper {
  static Future<void> openLink(String? url) async {
    if (url == null || url.isEmpty) {
      Get.snackbar("Unavailable", "This instructor did not provide a link.");
      return;
    }

    final Uri uri = Uri.parse(url);

    if (!await canLaunchUrl(uri)) {
      Get.snackbar("Error", "Invalid or broken link.");
      return;
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
