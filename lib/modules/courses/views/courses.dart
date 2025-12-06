import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/courses/controllers/courses_controller.dart';
import 'package:hkdigiskill/modules/courses/widgets/animated_course_card.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/custom_shimmer.dart';
import 'package:hkdigiskill/shared/widgets/no_data_widget.dart';
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
              Obx(
                () => (controller.isLoading.value)
                    ? Text(
                        "Enrolled Course",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'Poppins',
                        ),
                      )
                    : (controller.myCourse.isEmpty)
                    ? SizedBox.shrink()
                    : Text(
                        "Enrolled Course",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'Poppins',
                        ),
                      ),
              ),
              Obx(
                () =>
                    (controller.isLoading.value || controller.myCourse.isEmpty)
                    ? Center(
                        child: controller.isLoading.value
                            ? Gap(20)
                            : SizedBox.shrink(),
                      )
                    : Gap(20),
              ),
              Obx(
                () => (controller.isLoading.value)
                    ? ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _courseCardShimmer(),
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: 3,
                      )
                    : (controller.myCourse.isEmpty)
                    ? SizedBox.shrink()
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final course = controller.myCourse[index];
                          return AnimatedCourseCard(
                            course: course,
                            index: index,
                            onTap: () {
                              Get.toNamed(
                                Routes.courseDetails,
                                arguments: course,
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: controller.myCourse.length,
                      ),
              ),
              Obx(
                () =>
                    (controller.isLoading.value || controller.myCourse.isEmpty)
                    ? Center(
                        child: controller.isLoading.value
                            ? Gap(20)
                            : SizedBox.shrink(),
                      )
                    : Gap(20),
              ),
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => _courseCardShimmer(),
                        separatorBuilder: (context, index) => const Gap(10),
                        itemCount: 3,
                      )
                    : (controller.courses.isEmpty)
                    ? NoDataWidget()
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final course = controller.courses[index];
                          return AnimatedCourseCard(
                            course: course,
                            index: index,
                            onTap: () {
                              Get.toNamed(
                                Routes.courseDetails,
                                arguments: course,
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const Gap(10),
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
