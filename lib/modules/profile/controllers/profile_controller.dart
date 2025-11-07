import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class ProfileController extends GetxController {
  // -1 means none expanded, 0=Learning, 1=Company, 2=Account
  RxInt expandedSection = (-1).obs;
  final storage = StorageService();

  @override
  void onInit() {
    Future.microtask(() => _initLogo());
    super.onInit();
  }

  Future<void> _initLogo() async {
    final context = Get.context;
    if (context != null) {
      // ✅ Preload images to remove loading lag
      await Future.wait([precacheImage(AssetImage(AppImages.logo), context)]);
    }
  }

  void toggleSection(int index) {
    if (expandedSection.value == index) {
      expandedSection.value = -1; // Collapse if already open
    } else {
      expandedSection.value = index; // Open
    }
  }

  final nameCtrl = TextEditingController(text: 'Marvin McKinney');
  final phoneCtrl = TextEditingController(text: 'marvin@email.com');
  final designationCtrl = TextEditingController(text: 'Student');
  final RxString photoUrl =
      'https://randomuser.me/api/portraits/men/32.jpg'.obs;

  void updateProfile() {
    // Your logic to update the profile
    // e.g., validate, call API, show dialog...
  }

  void showSignOutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Sign Out',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, // main color for confirm
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              storage.clearUserData();
              Get.offAllNamed(Routes.login);
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      barrierDismissible: false, // prevents accidental popup dismiss
    );
  }

  void onDeleteAccountTap(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final reasonController = TextEditingController();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Delete Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextField(
                label: 'Name',
                controller: nameController,
                isRequired: true,
                height: 50,
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                isRequired: true,
                height: 50,
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Password',
                controller: passwordController,
                obscureText: true,
                isRequired: true,
                height: 50,
              ),
              const SizedBox(height: 8),
              AppTextField(
                label: 'Reason for deleting account',
                controller: reasonController,
                minLines: 2,
                maxLines: 4,
                isRequired: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              final name = nameController.text.trim();
              final email = emailController.text.trim();
              final password = passwordController.text;
              final reason = reasonController.text.trim();

              // TODO: Your account deletion logic here (API call etc.)
              // Example:
              // deleteAccount(name, email, password, reason);

              Get.back(); // Dismiss dialog after action
            },
            child: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
