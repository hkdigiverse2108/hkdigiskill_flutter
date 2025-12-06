import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class SignIn extends GetView<SignInController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign In',
          style: TextStyle(
            color: AppColors.textLight,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              label: "Email",
              isRequired: true,
              keyboardType: TextInputType.emailAddress,
              controller: controller.emailController,
            ),
            Obx(
              () => AppTextField(
                label: "Password",
                isRequired: true,
                keyboardType: TextInputType.visiblePassword,
                controller: controller.passwordController,
                obscureText: controller.isPasswordVisible.value,
                suffixIcon: Obx(
                  () => IconButton(
                    icon: Icon(
                      controller.isPasswordVisible.value
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                      color: AppColors.textLight,
                    ),
                    onPressed: () {
                      controller.isPasswordVisible.value =
                          !controller.isPasswordVisible.value;
                    },
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: controller.onForgotPasswordTap,
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                "Forgot Password?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Gap(24),
            Obx(
              () => InkWell(
                onTap: controller.isLoading.value
                    ? null
                    : controller.onLoginTap,
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
                            "Log in",
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
                Text("Don't have an account? "),
                TextButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.onSignUpTap,
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  child: Text(
                    "Sign Up",
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
