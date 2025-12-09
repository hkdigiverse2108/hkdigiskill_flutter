import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/sign_up/controllers/sign_up_controller.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
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
              label: "Full Name",
              isRequired: true,
              controller: controller.fullNameController,
              hint: "Your full name",
            ),
            AppTextField(
              label: "Email",
              isRequired: true,
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
              hint: "study@email.com",
            ),
            Obx(
              () => AppTextField(
                label: "Password",
                isRequired: true,
                controller: controller.passwordController,
                obscureText: controller.obscurePassword.value,
                hint: "Your password",
                suffixIcon: IconButton(
                  icon: Icon(
                    controller.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.textLight.withOpacity(0.6),
                  ),
                  onPressed: () => controller.obscurePassword.toggle(),
                ),
              ),
            ),
            AppTextField(
              label: "Phone Number",
              isRequired: true,
              controller: controller.phoneNumberController,
              keyboardType: TextInputType.phone,
              hint: "0123 xxxx xxxx",
            ),
            AppTextField(
              label: "Designation",
              isRequired: true,
              controller: controller.designationController,
              hint: "Student",
            ),
            AppTextField(
              label: "Referral Code",
              controller: controller.referralCodeController,
              hint: "HKCourse2025",
            ),
            Gap(14),
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: controller.isAgree.value,
                      onChanged: (value) {
                        controller.onAgreeChanged(value!);
                      },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      activeColor: AppColors.primary,
                    ),
                  ),
                  Gap(8),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: AppColors.caption,
                          fontSize: 13,
                          fontFamily: 'Poppins',
                          height: 1.5,
                        ),
                        children: [
                          const TextSpan(text: 'I agree with the '),
                          TextSpan(
                            text: 'terms and conditions',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = controller.onTermsTap,
                          ),
                          const TextSpan(
                            text:
                                ' and also the protection of my personal data on this application',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(24),
            Obx(
              () => InkWell(
                onTap: controller.isLoading.value
                    ? null
                    : controller.isAgree.value
                    ? controller.onSignUpTap
                    : null,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: controller.isAgree.value
                        ? AppColors.primary
                        : AppColors.primary.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Sign Up",
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
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account? "),
                TextButton(
                  onPressed: controller.onSignInTap,
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
