import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/home/controllers/home_controller.dart';
import 'package:hkdigiskill/modules/home/widget/carousel_widget.dart';
import 'package:hkdigiskill/modules/home/widget/category_sectin.dart';
import 'package:hkdigiskill/modules/home/widget/popular_blogs_section.dart';
import 'package:hkdigiskill/modules/home/widget/popular_courses_section.dart';
import 'package:hkdigiskill/modules/home/widget/stat_counter_bar.dart';
import 'package:hkdigiskill/shared/widgets/top_bar.dart';
import 'package:hkdigiskill/shared/widgets/animated_on_scroll.dart'; // 👈 import this

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const TopBar(),
              const Gap(20),

              // 👇 Animate Carousel
              Obx(
                () => AnimatedOnScroll(
                  // animateOnce: false,
                  duration: const Duration(milliseconds: 400),
                  offsetY: 32.0, // slide up from 32 pixels below
                  child: ImageCardCarousel(
                    imageList: controller.imageList,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ),
              const Gap(10),

              // 👇 Animate Categories
              Obx(
                () => AnimatedOnScroll(
                  // animateOnce: false,
                  duration: const Duration(milliseconds: 400),
                  offsetY: 32.0, // slide up from 32 pixels below
                  child: CategoryGridSection(
                    categories: controller.categories,
                    onViewAll: controller.onCategoryViewAll,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ),
              const Gap(10),

              // 👇 Animate Courses
              Obx(
                () => AnimatedOnScroll(
                  // animateOnce: false,
                  duration: const Duration(milliseconds: 400),
                  offsetY: 32.0, // slide up from 32 pixels below
                  child: PopularCoursesSection(
                    courses: controller.courses,
                    onViewAll: controller.onCourseViewAll,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ),
              const Gap(10),

              // 👇 Animate Stats
              Obx(
                () => AnimatedOnScroll(
                  // animateOnce: false,
                  duration: const Duration(milliseconds: 400),
                  offsetY: 32.0,
                  // slide up from 32 pixels below
                  curve: Curves.bounceInOut,
                  // offsetY: -10,
                  child: StatCountersBar(
                    counters: controller.counters,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ),
              const Gap(10),

              // 👇 Animate Blogs
              Obx(
                () => AnimatedOnScroll(
                  // animateOnce: false,
                  duration: const Duration(milliseconds: 400),
                  offsetY: 32.0, // slide up from 32 pixels below
                  child: PopularBlogsSection(
                    blogs: controller.blogs,
                    onViewAll: controller.onBlogViewAll,
                    isLoading: controller.isLoading.value,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
