import 'package:get/get.dart';

class TestimonialsController extends GetxController {
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    onLoading();
  }

  final List<Testimonial> testimonials = [
    Testimonial(
      profileUrl: 'https://randomuser.me/api/portraits/men/31.jpg',
      name: 'Bob Limones',
      role: 'Student',
      review:
          'Lorem ipsum dolor amet consec tur elit adicing sed do usmod zx tempor enim minim veniam quis nostrud exer citation.',
    ),
    Testimonial(
      profileUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      name: 'Bob Limones',
      role: 'Student',
      review:
          'Lorem ipsum dolor amet consec tur elit adicing sed do usmod zx tempor enim minim veniam quis nostrud exer citation.',
    ),
  ];

  void onLoading() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      update();
    });
  }
}

class Testimonial {
  final String profileUrl;
  final String name;
  final String role;
  final String review;
  final int rating;
  final String badgeText;

  Testimonial({
    required this.profileUrl,
    required this.name,
    required this.role,
    required this.review,
    this.rating = 5,
    this.badgeText = "",
  });
}
