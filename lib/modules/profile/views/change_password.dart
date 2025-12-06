import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/profile/controllers/change_password_controller.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Password",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: ListView(
          children: [
            AppTextField(
              label: 'Old Password',
              controller: controller.oldPassCtrl,
              obscureText: true,
            ),
            AppTextField(
              label: 'New Password',
              controller: controller.newPassCtrl,
              obscureText: true,
            ),
            AppTextField(
              label: 'Confirm Password',
              controller: controller.confirmPassCtrl,
              obscureText: true,
            ),
            Gap(24),
            Obx(
              () => InkWell(
                onTap: controller.updatePassword,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Update Password",
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
    );
  }
}
