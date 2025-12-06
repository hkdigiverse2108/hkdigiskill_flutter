import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/courses/controllers/course_details_controller.dart';
import 'package:hkdigiskill/shared/widgets/expendable_description.dart';
import 'package:hkdigiskill/shared/widgets/faq_section.dart';
import 'package:hkdigiskill/modules/courses/widgets/header_badge.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/testimonial_card.dart';

class CourseDetailsScreen extends GetView<CourseDetailsController> {
  const CourseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              width: width,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
              child: (controller.course.value.image == null)
                  ? Image.asset(AppImages.courseImage, fit: BoxFit.cover)
                  : Image.network(
                      Globals.fixLocalhostUrl(controller.course.value.image!),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Image.asset(AppImages.courseImage, fit: BoxFit.cover),
                    ),
            ),
            Column(
              children: [
                Expanded(flex: 3, child: Container()),
                Expanded(
                  flex: 8,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back button
                                GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: 24,
                                  ),
                                ),
                                // Pill badges
                                Row(
                                  children: [
                                    HeaderBadge(
                                      label:
                                          controller.course.value.language ??
                                          "",
                                      icon: null,
                                    ),
                                    SizedBox(width: 8),
                                    HeaderBadge(
                                      label: Globals.convertMinutesToHoursDays(
                                        controller.course.value.duration ?? 0,
                                      ),
                                      icon: Icons.access_time_rounded,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Gap(2),
                        Expanded(
                          child: ShaderMask(
                            shaderCallback: (Rect rect) {
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withValues(alpha: 0.9),
                                  // 0% opaque at top
                                  Colors.transparent,
                                  // 100% opaque around 15%
                                  Colors.transparent,
                                  // 100% opaque
                                  Colors.white.withValues(alpha: 0.9),
                                  // 0% opaque at bottom
                                ],
                                stops: [0.01, 0.12, 0.88, 1.0],
                              ).createShader(rect);
                            },
                            blendMode: BlendMode.dstOut,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Title
                                  Text(
                                    controller.course.value.name ?? "",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  // Subtitle + Rating Row
                                  Row(
                                    children: [
                                      Text(
                                        controller
                                                .course
                                                .value
                                                .courseCategory!
                                                .name ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Color(0xFFFFB800),
                                        size: 20,
                                      ),
                                      SizedBox(width: 3),
                                      Text(
                                        "${controller.course.value.averageRating}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(width: 2),
                                      Text(
                                        "(${controller.course.value.totalRated} Reviews)",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  // Pills/Tabs Row
                                  Obx(
                                    () => Row(
                                      spacing: 5,
                                      children: [
                                        ...controller.tabs.map(
                                          (tab) => _courseTab(
                                            tab.title,
                                            selected:
                                                controller.selectedTab.value ==
                                                controller.tabs.indexOf(tab),
                                            index: controller.tabs.indexOf(tab),
                                            onTap: controller.changeTab,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 16),
                                  Obx(
                                    () =>
                                        switch (controller.selectedTab.value) {
                                          0 => _aboutSection(),
                                          1 => _curriculumSection(),
                                          2 => _reviewsSection(),
                                          3 => FaqSection(
                                            faqs: controller.faqs,
                                          ),
                                          _ => Container(),
                                        },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => (controller.isLoading.value)
                              ? SizedBox.shrink()
                              : controller.course.value.isUnlocked!
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Price section
                                      Row(
                                        children: [
                                          Text(
                                            "₹ ${controller.course.value.price}",
                                            style: TextStyle(
                                              color: AppColors.textLight,
                                              fontSize: 22,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "₹ ${controller.course.value.mrpPrice}",
                                            style: TextStyle(
                                              color: AppColors.error,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      // Buy Now button
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF264A73),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 10,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.toNamed(
                                            Routes.pay,
                                            arguments: {
                                              'course': controller.course.value,
                                              'isCourse': true,
                                            },
                                          );
                                        },
                                        child: Text(
                                          "Buy Now",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
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
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _courseTab(
    String label, {
    bool selected = false,
    int index = 0,
    Function(int)? onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap?.call(index),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? Color(0xFF264A73) : Colors.grey[200],
            borderRadius: BorderRadius.circular(7),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? Colors.white : Colors.grey[700],
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }

  Widget _aboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Description
        ExpandableDescription(text: controller.course.value.description ?? ""),
        SizedBox(height: 18),
        // Download Brochures Button
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
            side: BorderSide(color: Color(0xFF264A73), width: 2),
          ),
          onPressed: () {
            // Download brochures handler
          },
          child: Center(
            child: Text(
              "Download Brochures",
              style: TextStyle(
                color: Color(0xFF264A73),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _curriculumSection() {
    return Obx(() {
      if (controller.isLessonsLoading.value ||
          controller.isCurriculumLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.lessons.isEmpty) {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("No lessons available"),
        );
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controller.lessons.map((lesson) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 14),

                /// 🔥 LESSON TITLE + PRIORITY
                Text(
                  "${lesson.priority + 1}. ${lesson.title}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Poppins',
                  ),
                ),

                /// If no curriculum attached
                if (lesson.curriculum.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0, left: 12),
                    child: Text(
                      "No curriculum available",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),

                /// 🔥 CURRICULUM ITEMS FOR THIS LESSON
                ...lesson.curriculum.map((cur) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: ListTile(
                        onTap: () {
                          Get.toNamed(
                            Routes.video,
                            arguments: {
                              'videoId': cur.videoLink,
                              'title': cur.title,
                              'description': cur.description,
                              'duration': cur.duration,
                              'attachment': cur.attachment,
                            },
                          );
                        },

                        /// 🔥 Circle Leading Icon
                        leading: Container(
                          width: 100,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(
                                Globals.fixLocalhostUrl(cur.thumbnail),
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Opacity(
                            opacity: 0.5,
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.grey,
                              size: 30,
                            ),
                          ),
                        ),

                        title: Text(
                          cur.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            color: Colors.black,
                          ),
                        ),

                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            /// Upload date
                            Text(
                              "Upload: ${cur.date != null ? cur.date!.toLocal().toString().split(' ')[0] : '-'}",
                              style: const TextStyle(
                                fontSize: 11,
                                fontFamily: 'Poppins',
                              ),
                            ),

                            Row(
                              children: [
                                /// Lesson Lock Check
                                if (!controller.course.value.isUnlocked! &&
                                    (lesson.lessonLock || cur.curriculumLock))
                                  Icon(
                                    Icons.lock,
                                    color: AppColors.primary,
                                    size: 20,
                                  ),

                                /// Duration
                                Text(
                                  cur.duration,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: AppColors.primary,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          }),
        ],
      );
    });
  }

  Widget _reviewsSection() {
    return Obx(
      () => controller.isTestimonialsLoading.value
          ? Center(child: CircularProgressIndicator())
          : controller.testimonials.isEmpty
          ? Center(child: Text("No Testimonial found."))
          : Column(
              children: [
                ...controller.testimonials.map((testimonial) {
                  return testimonialCard(
                    imageUrl: Globals.fixLocalhostUrl(testimonial.image),
                    date: Globals.formatDate(testimonial.createdAt),
                    title: testimonial.name,
                    description: testimonial.description,
                  );
                }),
              ],
            ),
    );
  }
}
