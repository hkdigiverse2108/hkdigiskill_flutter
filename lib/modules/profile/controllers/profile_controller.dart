import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  // -1 means none expanded, 0=Learning, 1=Company, 2=Account
  RxInt expandedSection = (-1).obs;

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
}
