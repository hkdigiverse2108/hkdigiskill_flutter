import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/new_password/controllers/new_password_controller.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class NewPassword extends GetView<NewPasswordController> {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Password',
          style: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.textLight),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: "New Password",
              isRequired: true,
              controller: controller.newPasswordController,
              hint: "Abc@123",
            ),
            Gap(10),
            AppTextField(
              label: "Confirm Password",
              isRequired: true,
              controller: controller.confirmPasswordController,
              hint: "Abc@123",
            ),
            TextButton(
              onPressed: controller.onNeedHelpTap,
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text("Need Help?"),
            ),
            Gap(16),
            InkWell(
              onTap: controller.onSetNewPasswordTap,
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Set New Password",
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
    );
  }
}
