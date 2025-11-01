import 'package:get/get.dart';

class Instructor {
  final String name;
  final String role;
  final String imageUrl;

  Instructor({required this.name, required this.role, required this.imageUrl});
}

class InstructorController extends GetxController {
  var instructors = <Instructor>[
    Instructor(
      name: 'Jane Seymour',
      role: 'UI Designer',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    Instructor(
      name: 'Edward Norton',
      role: 'UI Designer',
      imageUrl: 'https://randomuser.me/api/portraits/men/12.jpg',
    ),
    Instructor(
      name: 'Jane Seymour',
      role: 'UI Designer',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    Instructor(
      name: 'Edward Norton',
      role: 'UI Designer',
      imageUrl: 'https://randomuser.me/api/portraits/men/12.jpg',
    ),
    Instructor(
      name: 'Jane Seymour',
      role: 'UI Designer',
      imageUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    ),
    Instructor(
      name: 'Edward Norton',
      role: 'UI Designer',
      imageUrl: 'https://randomuser.me/api/portraits/men/12.jpg',
    ),
  ].obs;

  // controls which instructor's icons are shown
  var showIcons = <RxBool>[].obs;

  @override
  void onInit() {
    showIcons.value = List.generate(instructors.length, (_) => false.obs);
    super.onInit();
  }

  void toggleIcons(int index) {
    // Hide others, toggle current
    for (int i = 0; i < showIcons.length; i++) {
      showIcons[i].value = i == index ? !showIcons[i].value : false;
    }
  }
}
