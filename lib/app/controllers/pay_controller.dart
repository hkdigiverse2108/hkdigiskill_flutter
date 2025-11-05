import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/services/payment_service.dart';
import 'package:hkdigiskill/shared/widgets/purchase_result_dialog.dart';

class PayController extends GetxController {
  // Coupon Text Controller
  final TextEditingController couponController = TextEditingController();

  // Amount values
  RxDouble discount = 0.0.obs;
  RxDouble couponValue = 0.0.obs;
  RxDouble subtotal = 300.0.obs;
  RxDouble total = 300.0.obs;

  RxBool isSuccess = false.obs;
  RxBool isLoading = false.obs;
  RxBool isProcessing = false.obs;

  // Example valid coupon(s)
  final String validCoupon = "SAVE250";

  @override
  void onClose() {
    couponController.dispose();
    super.onClose();
  }

  void applyCoupon() {
    final code = couponController.text.trim();
    if (code.isEmpty) {
      Get.snackbar("Error", "Please enter a coupon code");
      return;
    }
    if (code == validCoupon) {
      discount.value = -0.00; // Assuming discount is negative for display
      couponValue.value = -250.00;
      subtotal.value = 49.0; // You can adjust these based on business logic
      total.value =
          49.0; // Should total = subtotal + discount + couponValue? Adjust as needed
      Get.snackbar("Success", "Coupon applied!");
    } else {
      discount.value = 0;
      couponValue.value = 0;
      subtotal.value = 49.0;
      total.value = 49.0;
      Get.snackbar(
        "Invalid Coupon",
        "The coupon code you entered is not valid.",
      );
    }
  }

  void proceedToCheckout({required BuildContext context}) {
    if (isSuccess.value) {
      showDialog(
        context: context,
        builder: (_) => PurchaseResultDialog(
          status: PurchaseStatus.success,
          transactionId: "#wbdjwdbjd",
          onClose: () => Get.back(),
          onRetry: () {},
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => PurchaseResultDialog(
          status: PurchaseStatus.failure,
          onClose: () {},
          onRetry: () {
            Get.back();
            onRetry(context: context);
          },
        ),
      );
    }
  }

  void purchase({required BuildContext context}) {
    isLoading.value = true;
    isProcessing.value = true;
    initiatePayment();
    Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
      isProcessing.value = false;
      isSuccess.value = true;
      proceedToCheckout(context: context);
    });
  }

  void initiatePayment() {
    // Use subtotal/total from this controller
    RazorpayService.to.openCheckout(
      amount: total.value,
      name: "HK Digiskill",
      description: "Course Purchase",
      email: "user@example.com",
      // from user data/storage
      contact: "1234567890", // from user data/storage
      // extraOptions: {...} if needed
    );
  }

  void onRetry({required BuildContext context}) {
    purchase(context: context);
  }
}
