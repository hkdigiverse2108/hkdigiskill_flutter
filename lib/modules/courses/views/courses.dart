import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/courses/controllers/courses_controller.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';
import 'package:hkdigiskill/shared/widgets/top_bar.dart';

class Courses extends GetView<CoursesController> {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: (controller.isFilterMode.value)
          ? AppBar(
              title: const Text(
                'Courses',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.black87),
            )
          : null,
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!controller.isFilterMode.value) TopBar(),
              (controller.isFilterMode.value) ? Gap(10) : Gap(20),
              Text(
                "Enrolled Course",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  fontFamily: 'Poppins',
                ),
              ),
              Gap(20),
              Obx(
                () => (controller.isLoading.value)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _courseCardShimmer(),
                        separatorBuilder: (context, index) => Gap(10),
                        itemCount: 3,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final course = controller.courses[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.courseDetails,
                                arguments: course,
                              );
                            },
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(
                                      0xFF64748B,
                                    ).withValues(alpha: 0.2),
                                    blurRadius: 9,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image + badge
                                  Expanded(
                                    flex: 3,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                course["image"],
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryLight,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_rounded,
                                                  size: 12,
                                                  color: AppColors.primary,
                                                ),
                                                const SizedBox(width: 3),
                                                Text(
                                                  course["duration"],
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Course details
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            course["title"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF263245),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          // ratings
                                          Row(
                                            children: [
                                              ...List.generate(
                                                5,
                                                (index) => Icon(
                                                  Icons.star,
                                                  size: 15,
                                                  color: Color(0xFFFFB800),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "(${course["rating"]}/ ${course["ratingCount"]} Ratings)",
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          // price
                                          Text(
                                            course["price"],
                                            style: TextStyle(
                                              color: Color(0xFFF05E54),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          // lessons and students
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.menu_book_outlined,
                                                color: AppColors.caption,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${course["lessons"]} Lessons",
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Gap(4),
                                              Text(
                                                '|',
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Gap(4),
                                              Icon(
                                                Icons.person_outline_rounded,
                                                color: AppColors.caption,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${course["students"]} Students",
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Gap(10),
                        itemCount: controller.courses.length,
                      ),
              ),
              Gap(20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Explore more",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.viewAllCourse);
                    }, // handle view all
                    child: Text(
                      "view all",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(20),
              Obx(
                () => (controller.isLoading.value)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _courseCardShimmer(),
                        separatorBuilder: (context, index) => Gap(10),
                        itemCount: 3,
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final course = controller.courses[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed(
                                Routes.courseDetails,
                                arguments: course,
                              );
                            },
                            child: Container(
                              height: 130,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(
                                      0xFF64748B,
                                    ).withValues(alpha: 0.2),
                                    blurRadius: 9,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image + badge
                                  Expanded(
                                    flex: 3,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 130,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                course["image"],
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryLight,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time_rounded,
                                                  size: 12,
                                                  color: AppColors.primary,
                                                ),
                                                const SizedBox(width: 3),
                                                Text(
                                                  course["duration"],
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Course details
                                  Expanded(
                                    flex: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            course["title"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              color: Color(0xFF263245),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          // ratings
                                          Row(
                                            children: [
                                              ...List.generate(
                                                5,
                                                (index) => Icon(
                                                  Icons.star,
                                                  size: 15,
                                                  color: Color(0xFFFFB800),
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "(${course["rating"]}/ ${course["ratingCount"]} Ratings)",
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 12,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          // price
                                          Text(
                                            course["price"],
                                            style: TextStyle(
                                              color: Color(0xFFF05E54),
                                              fontSize: 14,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          // lessons and students
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.menu_book_outlined,
                                                color: AppColors.caption,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${course["lessons"]} Lessons",
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Gap(4),
                                              Text(
                                                '|',
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const Gap(4),
                                              Icon(
                                                Icons.person_outline_rounded,
                                                color: AppColors.caption,
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                "${course["students"]} Students",
                                                style: TextStyle(
                                                  color: AppColors.caption,
                                                  fontSize: 11,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Gap(10),
                        itemCount: controller.courses.length,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _courseCardShimmer() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 9),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder + badge
          Expanded(
            flex: 3,
            child: CustomShimmer(
              isLoading: true,
              child: Stack(
                children: [
                  // Image skeleton
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Badge skeleton
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Container(
                            width: 40,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Details skeleton
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomShimmer(
                isLoading: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Title skeleton
                    Container(
                      width: double.infinity,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Rating skeleton
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (index) => Container(
                            width: 15,
                            height: 15,
                            margin: const EdgeInsets.only(right: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 60,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Price skeleton
                    Container(
                      width: 50,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Info row skeleton
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 54,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const Gap(10),
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 54,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
