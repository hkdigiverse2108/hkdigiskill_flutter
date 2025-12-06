import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/profile/controllers/profile_controller.dart';
import 'package:hkdigiskill/modules/profile/widgets/custom_menu_section.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:hkdigiskill/shared/widgets/widget_animation_wrapper.dart';

class ProfileMenuPage extends GetView<ProfileController> {
  const ProfileMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          children: [
            const Gap(0),
            Image.asset(height: 50, width: 80, AppImages.logo),
            const Gap(12),
            Divider(height: 1, color: AppColors.caption.withValues(alpha: 0.3)),
            const Gap(10),
            // Profile card
            WidgetAnimationWrapper(
              animationTypes: [AnimationType.fade],
              index: 0,
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Container(
                  height: 58,
                  width: 58,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.caption.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(4),
                  child: Hero(
                    tag: 'profile-avatar',
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        Globals.fixLocalhostUrl(
                          Globals.userData?.profilePhoto ?? "",
                        ),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  "Welcome",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 14),
                ),
                subtitle: Text(
                  Globals.userData?.fullName ?? "",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                trailing: InkWell(
                  onTap: () => controller.showSignOutDialog(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.caption.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(14),
                    child: SvgPicture.asset(
                      AppImages.signOut,
                      height: 16,
                      width: 16,
                    ),
                  ),
                ),
                onTap: () {},
              ),
            ),
            const Gap(10),
            Divider(height: 1, color: AppColors.caption.withValues(alpha: 0.3)),
            const Gap(12),

            // ---- Menu Sections with expand/collapse ----
            Obx(
              () => WidgetAnimationWrapper(
                animationTypes: [AnimationType.slide, AnimationType.fade],
                index: 1,
                child: CustomMenuSection(
                  title: "Learning & Resources",
                  icon: Icons.person,
                  items: [
                    "Instructor",
                    "Blogs",
                    "Gallery",
                    "Testimonials",
                    "Frequent Ask Questions",
                  ],
                  actions: [
                    () {
                      Get.toNamed(Routes.topInstructors);
                    },
                    () {
                      Get.toNamed(Routes.blogs);
                    },
                    () {
                      Get.toNamed(Routes.gallery);
                    },
                    () {
                      Get.toNamed(Routes.testimonials);
                    },
                    () {
                      Get.toNamed(Routes.faq);
                    },
                  ],
                  expanded: controller.expandedSection.value == 0,
                  onHeaderTap: () => controller.toggleSection(0),
                ),
              ),
            ),
            Obx(
              () => WidgetAnimationWrapper(
                animationTypes: [AnimationType.slide, AnimationType.fade],
                index: 2,
                child: CustomMenuSection(
                  title: "Company & Legal Info",
                  icon: Icons.verified_user,
                  items: [
                    "About Us",
                    "Contact Us",
                    "Terms & Condition",
                    "Privacy Policy",
                    "News Letter",
                  ],
                  actions: [
                    () {
                      Get.toNamed(Routes.aboutUs);
                    },
                    () {
                      Get.toNamed(Routes.contactUs);
                    },
                    () {
                      Get.toNamed(Routes.termsCondition);
                    },
                    () {
                      Get.toNamed(Routes.privacyPolicy);
                    },
                    () {
                      controller.newsLetter();
                    },
                  ],
                  expanded: controller.expandedSection.value == 1,
                  onHeaderTap: () => controller.toggleSection(1),
                ),
              ),
            ),
            Obx(
              () => WidgetAnimationWrapper(
                animationTypes: [AnimationType.slide, AnimationType.fade],
                index: 3,
                child: CustomMenuSection(
                  title: "Account Settings",
                  icon: Icons.settings,
                  items: [
                    "Update Profile",
                    "Change Password",
                    "Delete Account",
                  ],
                  actions: [
                    () {
                      Get.toNamed(Routes.updateProfile);
                    },
                    () {
                      Get.toNamed(Routes.changePassword);
                    },
                    () {
                      controller.onDeleteAccountTap(context);
                    },
                  ],
                  expanded: controller.expandedSection.value == 2,
                  onHeaderTap: () => controller.toggleSection(2),
                ),
              ),
            ),

            const SizedBox(height: 40),
            WidgetAnimationWrapper(
              animationTypes: [AnimationType.slide, AnimationType.fade],
              index: 4,
              child: GestureDetector(
                onTap: () {}, // Help callback
                child: Container(
                  height: 85,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(AppImages.help, fit: BoxFit.fill),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
