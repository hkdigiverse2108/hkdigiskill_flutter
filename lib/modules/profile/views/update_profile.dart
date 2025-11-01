import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/profile/controllers/profile_controller.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class UpdateProfilePage extends GetView<ProfileController> {
  const UpdateProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 14),
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Obx(
                    () => CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(controller.photoUrl.value),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 2,
                    child: InkWell(
                      onTap: () {
                        // Upload/select photo logic
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              AppTextField(label: 'Name', controller: controller.nameCtrl),
              AppTextField(
                label: 'Phone Number',
                controller: controller.phoneCtrl,
              ),
              AppTextField(
                label: 'Designation',
                controller: controller.designationCtrl,
              ),
              Gap(24),
              InkWell(
                onTap: controller.updateProfile,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      "Update Profile",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                    ),
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
