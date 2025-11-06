import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:get/get.dart';

class RazorpayService extends GetxService {
  late Razorpay _razorpay;

  static RazorpayService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckout({
    required double amount,
    required String name,
    required String description,
    required String email,
    required String contact,
    Map<String, dynamic>? extraOptions,
  }) {
    final options = {
      'key': 'rzp_live_jnqgXIwCukFNcO',
      // Todo: update this key with original key
      'amount': (amount * 100).toInt(),
      // amount in paise
      'name': name,
      'description': description,
      'prefill': {'contact': contact, 'email': email},
      ...?extraOptions,
    };
    _razorpay.open(options);
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    // You might want to call a callback, or use events/dialogs
    Get.snackbar("Payment Success", "Payment ID: ${response.paymentId}");
    // Custom: pass data to interested controller
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Payment Failed", "${response.message}");
    // Custom failure logic
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
