import 'package:get/get.dart';

class Blog {
  final String date;
  final String imageUrl;
  final String category;
  final String title;
  final String description;

  Blog({
    required this.date,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.description,
  });
}

class BlogController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Blog> blogs = <Blog>[
    Blog(
      date: '15 Nov, 2023',
      imageUrl: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2',
      category: 'SCIENCE',
      title: 'Crafting Effective Learning Guide Line',
      description:
          'Consectetur adipisicing elit, sed do eiusmod tempor inc idid unt...',
    ),
    Blog(
      date: '15 Nov, 2023',
      imageUrl: 'https://images.unsplash.com/photo-1515378791036-0648a3ef77b2',
      category: 'SCIENCE',
      title: 'Crafting Effective Learning Guide Line',
      description:
          'Consectetur adipisicing elit, sed do eiusmod tempor inc idid unt...',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    onLoading();
  }

  void onLoading() {
    isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      update();
    });
  }
}
