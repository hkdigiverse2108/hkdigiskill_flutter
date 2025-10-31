import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/modules/otp_verify/controllers/otp_verify_controller.dart';
import 'package:hkdigiskill/shared/widgets/app_text_field.dart';

class OtpVerify extends GetView<OtpVerifyController> {
  const OtpVerify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OTP Verify',
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
            RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.caption,
                  fontSize: 15,
                  fontFamily: 'Poppins',
                ),
                children: [
                  const TextSpan(
                    text: 'An OTP has been sent to your email address: ',
                  ),
                  TextSpan(
                    text: controller.email,
                    style: TextStyle(
                      color: AppColors.info,
                      // decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: '. Please enter it below to verify.'),
                ],
              ),
            ),
            Gap(14),
            AppTextField(
              label: "One Time Password",
              isRequired: true,
              controller: controller.otpController,
              hint: "= = = = = =",
            ),
            Gap(10),
            InkWell(
              onTap: controller.onVerifyTap,
              child: Container(
                height: 56,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Verify",
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
            Gap(20),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t Received OTP? "),
                  (controller.isCountDown.value)
                      ? Text("${controller.countDown.value} seconds left")
                      : TextButton(
                          onPressed: controller.resetCountDown,
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text("Resend"),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
