import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/workshops/controllers/workshop_details_controller.dart';
import 'package:hkdigiskill/shared/widgets/expendable_description.dart';
import 'package:hkdigiskill/shared/widgets/faq_section.dart';
import 'package:hkdigiskill/modules/courses/widgets/header_badge.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/testimonial_card.dart';

class WorkshopDetailsScreen extends GetView<WorkshopDetailsController> {
  const WorkshopDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
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
            child: (controller.workshop.value.image == null)
                ? Image.asset(AppImages.courseImage, fit: BoxFit.cover)
                : Image.network(
                    Globals.fixLocalhostUrl(controller.workshop.value.image!),
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
                                        controller.workshop.value.language ??
                                        "English",
                                    icon: null,
                                  ),
                                  SizedBox(width: 8),
                                  HeaderBadge(
                                    label:
                                        "${controller.workshop.value.duration}",
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
                                  "${controller.workshop.value.title}",
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
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFFFB800),
                                      size: 20,
                                    ),
                                    SizedBox(width: 3),
                                    Text(
                                      "${controller.workshop.value.averageRating}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      "(${controller.workshop.value.totalRated} Reviews)",
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
                                        (tab) => _workshopTab(
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
                                  () => switch (controller.selectedTab.value) {
                                    0 => _aboutSection(),
                                    1 => _curriculumSection(),
                                    2 => _reviewsSection(),
                                    3 => FaqSection(faqs: controller.faqs),
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
                            : controller.workshop.value.isUnlocked!
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
                                          "₹ ${controller.workshop.value.price}",
                                          style: TextStyle(
                                            color: AppColors.textLight,
                                            fontSize: 22,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "₹ ${controller.workshop.value.mrpPrice}",
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
                                            'workshop':
                                                controller.workshop.value,
                                            'isCourse': false,
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
  }

  Widget _workshopTab(
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
        ExpandableDescription(text: controller.workshop.value.about ?? ""),
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
            controller.downloadBrochure();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.isCurriculumLoading.value)
          Center(child: CircularProgressIndicator()),
        if (!controller.isCurriculumLoading.value &&
            controller.curriculumList.isEmpty)
          Center(child: Text("No curriculum found.")),
        ...controller.curriculumList.map((section) {
          return Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(22),
              ),
              child: ListTile(
                onTap: !controller.workshop.value.isUnlocked!
                    ? () {
                        Get.snackbar(
                          "Verification Required",
                          "You have to unlock this workshop to watch the video",
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    : () {
                        Get.toNamed(
                          Routes.video,
                          arguments: {
                            'videoId': section.videoLink,
                            'title': section.title,
                            'description': section.description,
                            'duration': section.duration,
                            'attachment': section.attachment,
                          },
                        );
                      },
                leading: Container(
                  width: 100,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        Globals.fixLocalhostUrl(section.thumbnail),
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
                  section.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black,
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Upload By: ${Globals.formatDate(section.createdAt!)}",
                      style: TextStyle(fontSize: 11, fontFamily: 'Poppins'),
                    ),
                    Row(
                      children: [
                        if (!controller.workshop.value.isUnlocked!)
                          Icon(Icons.lock, color: AppColors.primary, size: 20),
                        Text(
                          section.duration,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
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
