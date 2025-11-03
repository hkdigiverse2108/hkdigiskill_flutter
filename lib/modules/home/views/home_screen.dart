import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/modules/home/controllers/home_controller.dart';
import 'package:hkdigiskill/modules/home/widget/carousel_widget.dart';
import 'package:hkdigiskill/modules/home/widget/category_sectin.dart';
import 'package:hkdigiskill/modules/home/widget/popular_blogs_section.dart';
import 'package:hkdigiskill/modules/home/widget/popular_courses_section.dart';
import 'package:hkdigiskill/modules/home/widget/stat_counter_bar.dart';
import 'package:hkdigiskill/shared/widgets/top_bar.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TopBar(),
              Gap(20),
              ImageCardCarousel(imageList: controller.imageList),
              Gap(10),
              CategoryGridSection(
                categories: controller.categories,
                onViewAll: controller.onCategoryViewAll,
              ),
              Gap(10),
              PopularCoursesSection(
                courses: controller.courses,
                onViewAll: controller.onCourseViewAll,
              ),
              Gap(10),
              StatCountersBar(counters: controller.counters),
              Gap(10),
              PopularBlogsSection(
                blogs: controller.blogs,
                onViewAll: controller.onBlogViewAll,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
