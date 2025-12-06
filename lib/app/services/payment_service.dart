import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';

class RazorpayService extends GetxService {
  late Razorpay _razorpay;

  Function(PaymentSuccessResponse)? onSuccess;
  Function(PaymentFailureResponse)? onError;

  static RazorpayService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
  }

  void openCheckout({
    required double amount,
    required String name,
    required String description,
    required String email,
    required String contact,
    Function(PaymentSuccessResponse)? onSuccessCallback,
    Function(PaymentFailureResponse)? onErrorCallback,
  }) {
    onSuccess = onSuccessCallback;
    onError = onErrorCallback;

    final options = {
      'key': Globals.appSettings?.razorpayKey ?? "",
      'amount': (amount * 100).toInt(),
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email},
    };

    _razorpay.open(options);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    if (onSuccess != null) onSuccess!(response);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    if (onError != null) onError!(response);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("Wallet Selected", "${response.walletName}");
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }
}
