import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hkdigiskill/app/models/courses/course_models.dart';
import 'package:hkdigiskill/app/models/workshop/workshop_model.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/payment_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/api_constants.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/modules/courses/controllers/courses_controller.dart';
import 'package:hkdigiskill/modules/workshops/controllers/workshops_controller.dart';
import 'package:hkdigiskill/shared/widgets/purchase_result_dialog.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayController extends GetxController {
  // Coupon Text Controller
  final TextEditingController couponController = TextEditingController();

  final workshopController = Get.put(WorkshopsController());
  final courseController = Get.put(CoursesController());

  // Amount values
  RxDouble discount = 0.0.obs;
  RxDouble couponValue = 0.0.obs;
  RxDouble subtotal = 0.0.obs;
  RxDouble total = 0.0.obs;

  RxBool isCourse = false.obs;

  RxString title = "".obs;

  RxBool isSuccess = false.obs;
  RxBool isLoading = false.obs;
  RxBool isProcessing = false.obs;

  CourseModel? course;
  WorkshopModel? workshop;

  @override
  void onInit() {
    var data = Get.arguments;
    isCourse.value = data['isCourse'];
    if (data['isCourse'] == true) {
      course = data['course'];
      title.value = course!.name!;
      subtotal.value = course!.price!.toDouble();
      total.value = course!.price!.toDouble();
    } else {
      workshop = data['workshop'];
      title.value = workshop!.title!;
      subtotal.value = workshop!.price!.toDouble();
      total.value = workshop!.price!.toDouble();
    }
    super.onInit();
  }

  @override
  void onClose() {
    couponController.dispose();
    super.onClose();
  }

  void applyCoupon() async {
    final code = couponController.text.trim();

    if (code.isEmpty) {
      Get.snackbar("Error", "Please enter a coupon code");
      return;
    }

    try {
      final apiResponse = await ApiService.to.post(
        ApiConstants.couponEndpoint,
        headers: {"authorization": "${Globals.userData.value!.token}"},
        body: {"code": code, "amount": total.value},
      );

      if (apiResponse['status'] == 200) {
        final data = apiResponse['data'];

        discount.value = (data['discountAmount'] ?? 0).toDouble();
        total.value = (data['finalAmount'] ?? total.value).toDouble();

        /// optional if you want coupon object
        couponValue.value = (data['coupon']?['discountValue'] ?? 0).toDouble();

        Get.snackbar(
          "Coupon Applied",
          "${data['discountAmount']} discount applied!",
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar("Invalid", apiResponse['message']);
      }
    } catch (e) {
      log("Apply coupon error: $e");
      Get.snackbar("Error", "Failed to apply coupon");
    }
  }

  void proceedToCheckout({String? transactionId}) {
    if (isSuccess.value) {
      Get.dialog(
        PurchaseResultDialog(
          status: PurchaseStatus.success,
          transactionId: transactionId ?? '',
          onClose: () {
            Get.back(); // Close dialog
            Get.back(); // Go back to previous screen
          },
          onRetry: () {}, // No need to retry on success
        ),
        barrierDismissible: false,
      );
    } else {
      Get.dialog(
        PurchaseResultDialog(
          status: PurchaseStatus.failure,
          onClose: () => Get.back(), // Just close the dialog
          onRetry: () {
            Get.back(); // Close dialog
          },
        ),
        barrierDismissible: false,
      );
    }
  }

  void purchase({required BuildContext context}) {
    isLoading.value = true;

    RazorpayService.to.openCheckout(
      amount: total.value,
      name: "HK Digiskill",
      description: title.value,
      email: Globals.userData.value!.email,
      contact: Globals.userData.value!.phoneNumber ?? "0000000000",

      onSuccessCallback: (success) {
        handlePaymentSuccess(success, context);
      },

      onErrorCallback: (error) {
        handlePaymentError(error, context);
      },
    );
  }

  void handlePaymentSuccess(
    PaymentSuccessResponse response,
    BuildContext context,
  ) async {
    isSuccess.value = true;
    isLoading.value = false;

    Get.back();

    try {
      if (isCourse.value) {
        final body = {
          "courseId": course!.id,
          "razorpayOrderId": "a",
          "razorpayPaymentId": response.paymentId,
        };

        log(body.toString());
        final apiResponse = await ApiService.to.post(
          ApiConstants.coursePaymentEndpoint,
          body: {
            "courseId": course!.id,
            "razorpayOrderId": response.paymentId,
            "razorpayPaymentId": response.paymentId,
          },
        );

        if (apiResponse['status'] == 200) {
          courseController.onInit();
          proceedToCheckout(transactionId: response.paymentId.toString());
        }
      } else {
        final apiResponse = await ApiService.to.post(
          ApiConstants.workshopPaymentEndpoint,
          headers: {"authorization": "${Globals.userData.value!.token}"},
          body: {
            "workshopId": workshop!.id,
            "amount": total.value,
            "paymentId": response.paymentId,
            "paymentMethod": "razorpay",
            "finalAmount": total.value,
          },
        );

        if (apiResponse['status'] == 200) {
          workshopController.onInit();
          proceedToCheckout(transactionId: response.paymentId.toString());
        }
      }
    } catch (e) {
      log("Error : $e");
      Get.snackbar("Error", "Payment verified but API failed.");
    }
  }

  void handlePaymentError(
    PaymentFailureResponse response,
    BuildContext context,
  ) {
    isLoading.value = false;
    isSuccess.value = false;
    Get.back(); // Close the payment dialog
    proceedToCheckout(); // Show error dialog
  }

  void onRetry({required BuildContext context}) {
    purchase(context: context);
  }
}
