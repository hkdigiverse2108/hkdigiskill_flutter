import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/modules/app_info/controllers/terms_condition_controller.dart';
import 'package:hkdigiskill/shared/widgets/widget_animation_wrapper.dart';

class TermsConditionPage extends GetView<TermsConditionController> {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with back arrow and centered title
      appBar: AppBar(
        title: Text(
          'Terms & Conditions',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: WidgetAnimationWrapper(
                  index: 0,
                  animationTypes: [AnimationType.fade],
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'T & C',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => Text(
                          controller.content.value,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
