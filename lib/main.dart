import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/payment_service.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:device_preview/device_preview.dart';

import 'app/bindings/splash_binding.dart';
import 'app/themes/app_theme.dart';
import 'app/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX storage
  await GetStorage.init();

  Future.delayed(Duration.zero, () async {
    await initializeServices();
  });

  runApp(
    DevicePreview(
      enabled: !bool.fromEnvironment('dart.vm.product'),
      // Enable only in debug/dev
      builder: (context) => const MyApp(),
    ),
  );
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
      useInheritedMediaQuery: true,
      // <--- important for DevicePreview
      builder: DevicePreview.appBuilder,
      // <--- important for DevicePreview
      locale: DevicePreview.locale(context),
      // <--- use preview's selected locale
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.fade,
      fallbackLocale: const Locale('en', 'US'),
    );
  }
}
