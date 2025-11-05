import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkController extends GetxController {
  RxBool isConnected = true.obs;
  late Timer _timer;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  static NetworkController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    log("Checking Network connection...");
    _checkConnection(); // Initial check
    _timer = Timer.periodic(
      Duration(seconds: 5),
      (timer) => _checkConnection(),
    );

    // Listen for connectivity changes
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      final connected = results.any(
        (result) => result != ConnectivityResult.none,
      );
      log("Connectivity changed: $connected");
      if (!connected && isConnected.value) {
        // Just lost connection, show snackbar
        Get.snackbar(
          "No Internet",
          "Please check your network connection.",
          snackPosition: SnackPosition.TOP,
          // margin: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.85),
          colorText: Get.theme.colorScheme.onError,
          duration: Duration(seconds: 5),
        );
      }
      isConnected.value = connected;
    });
  }

  void _checkConnection() async {
    var results = await Connectivity().checkConnectivity();
    bool connected = results.any((r) => r != ConnectivityResult.none);
    if (!connected && isConnected.value) {
      log("Lost connection");
      // Just lost connection, show snackbar
      Get.snackbar(
        "No Internet",
        "Please check your network connection.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.85),
        colorText: Get.theme.colorScheme.onError,
        duration: Duration(seconds: 5),
      );
    }
    isConnected.value = connected;
  }

  @override
  void onClose() {
    _timer.cancel();
    _connectivitySubscription?.cancel();
    super.onClose();
  }
}
