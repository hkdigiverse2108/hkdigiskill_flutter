import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/routes/routes.dart';

class ProfileController extends GetxController {
  // -1 means none expanded, 0=Learning, 1=Company, 2=Account
  RxInt expandedSection = (-1).obs;
  final storage = StorageService();

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

  void signOut() {
    storage.clearUserData();
    Get.offAllNamed(Routes.login);
  }
}
