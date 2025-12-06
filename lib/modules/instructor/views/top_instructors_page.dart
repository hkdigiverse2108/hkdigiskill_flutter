import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/instructor/instructor_model.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/instructor/controllers/instructor_controller.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/modules/instructor/widgets/Instructor_animation_wrapper.dart';
import 'package:hkdigiskill/shared/widgets/social_link_helper.dart';

class TopInstructorsPage extends GetView<InstructorController> {
  const TopInstructorsPage({super.key});

  Widget _circleIcon(String asset, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 16,
          child: SvgPicture.asset(
            asset,
            width: 16,
            height: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildInstructorCard(InstructorModel data, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          // Instructor image - tap to show icons
          GestureDetector(
            onTap: () => controller.toggleIcons(index),
            child: Container(
              width: double.infinity,
              color: Colors.grey.shade100,
              child: Image.network(
                Globals.fixLocalhostUrl(data.image ?? ""),
                fit: BoxFit.cover,
                height: 200,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade100,
                    child: const Center(child: Icon(Icons.error)),
                  );
                },
              ),
            ),
          ),
          // Social icons overlay (centered), only when active
          Obx(
            () => AnimatedOpacity(
              opacity: controller.showIcons[index].value ? 1 : 0,
              duration: const Duration(milliseconds: 260),
              curve: Curves.easeOutCubic,
              child: AnimatedScale(
                scale: controller.showIcons[index].value ? 1 : 0.80,
                duration: const Duration(milliseconds: 260),
                curve: Curves.easeOutBack,
                child: controller.showIcons[index].value
                    ? Center(
                        child: Container(
                          height: 200,
                          color: AppColors.primary.withValues(alpha: 0.35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Spacer(),
                              _circleIcon(AppImages.facebook, () {
                                SocialLinkHelper.openLink(data.facebook);
                              }),
                              Gap(4),
                              _circleIcon(AppImages.twitter, () {
                                SocialLinkHelper.openLink(data.twitter);
                              }),
                              Gap(4),
                              _circleIcon(AppImages.linkedin, () {
                                SocialLinkHelper.openLink(data.linkedin);
                              }),
                              const Spacer(),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),

          // Name & Role
          // Name label
          Positioned(
            bottom: 34,
            left: 4,
            // right: 1,
            child: Align(
              alignment: Alignment.center,
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.88),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    data.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),

          // Role label
          Positioned(
            bottom: 10,
            left: 4,
            // right: 0,
            child: Align(
              alignment: Alignment.center,
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 9,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.84),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    data.designation!,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[800],
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Top Instructors',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : GridView.builder(
                  itemCount: controller.instructors.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (context, i) => InstructorAnimationWrapper(
                    index: i,
                    child: _buildInstructorCard(controller.instructors[i], i),
                  ),
                ),
        ),
      ),
    );
  }
}
