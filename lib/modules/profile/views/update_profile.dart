import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
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
                  Obx(() {
                    final picked = controller.pickedImage.value;
                    final networkUrl = controller.photoUrl.value;

                    return Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.backgroundLight,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(5),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: picked != null
                            ? FileImage(picked)
                            : (networkUrl != null && networkUrl.isNotEmpty
                                  ? NetworkImage(
                                      Globals.fixLocalhostUrl(networkUrl),
                                    )
                                  : const AssetImage(
                                          "assets/images/user_placeholder.jpg",
                                        )
                                        as ImageProvider),
                      ),
                    );
                  }),
                  Positioned(
                    top: 0,
                    right: 2,
                    child: GestureDetector(
                      onTap: () {
                        Get.bottomSheet(
                          _buildImagePickerSheet(controller),
                          backgroundColor: Colors.white,
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
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
              Obx(
                () => InkWell(
                  onTap: controller.isLoading.value
                      ? null
                      : controller.validateFields,
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImagePickerSheet(ProfileController controller) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Choose Option",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text("Pick from Gallery"),
            onTap: () {
              Get.back();
              controller.pickImage();
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text("Take a Photo"),
            onTap: () {
              Get.back();
              controller.pickImage(camera: true);
            },
          ),
        ],
      ),
    );
  }
}
