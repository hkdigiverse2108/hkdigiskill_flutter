import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/controllers/pay_controller.dart';
import 'package:hkdigiskill/app/themes/app_colors.dart';
import 'package:hkdigiskill/app/utils/app_images.dart';
import 'package:hkdigiskill/modules/courses/widgets/header_badge.dart';

class Pay extends GetView<PayController> {
  const Pay({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Background image with overlay
          Container(
            width: width,
            height: height * 0.4,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.6),
            ),
            child: Image.asset(AppImages.courseImage, fit: BoxFit.cover),
          ),
          Column(
            children: [
              Expanded(flex: 3, child: Container()),
              Expanded(
                flex: 8,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => Get.back(),
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                  size: 24,
                                ),
                              ),
                              Row(
                                children: const [
                                  HeaderBadge(
                                    label: "03 Hours",
                                    icon: Icons.access_time_rounded,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Text(
                                  controller.title.value,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Coupon Section
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: controller.couponController,
                                      decoration: InputDecoration(
                                        hintText: 'Coupon code',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 8,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: controller.applyCoupon,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primary,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 14,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Apply coupon',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Discount',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            '${controller.discount.value.toStringAsFixed(2)} Rs',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Coupon Value',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Obx(
                                          () => Text(
                                            '${controller.couponValue.value.toStringAsFixed(2)} Rs',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Amount Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Subtotal:',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '₹${controller.subtotal.value.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total:',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                  ),
                                  Obx(
                                    () => Text(
                                      '₹${controller.total.value.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 22),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => controller.isLoading.value
                                      ? null
                                      : controller.purchase(context: context),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primary ?? Colors.teal,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 18,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text(
                                    'Proceed to checkout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
