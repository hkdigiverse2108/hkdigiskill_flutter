import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/payment_service.dart';
import 'package:hkdigiskill/routes/routes.dart';

import 'app/bindings/splash_binding.dart';
import 'app/themes/app_theme.dart';
import 'app/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX storage
  await GetStorage.init();

  // Initialize services
  await initializeServices();

  runApp(const MyApp());
}

Future<void> initializeServices() async {
  // Initialize your services here
  Get.put(ApiService());
  Get.put(RazorpayService());
  Get.put(NetworkController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
