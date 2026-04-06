import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hkdigiskill/app/controllers/network_controller.dart';
import 'package:hkdigiskill/app/services/api_service.dart';
import 'package:hkdigiskill/app/services/payment_service.dart';
import 'package:hkdigiskill/app/services/settings_service.dart';
import 'package:hkdigiskill/app/services/storage_service.dart';
import 'package:hkdigiskill/app/utils/globals.dart';
import 'package:hkdigiskill/routes/routes.dart';
import 'package:device_preview/device_preview.dart';

import 'app/models/user/user_model.dart';
import 'app/themes/app_theme.dart';
import 'app/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Initialize GetX storage
  await GetStorage.init();
  HttpOverrides.global = MyHttpOverrides();

  Future.delayed(Duration.zero, () async {
    await initializeServices();
  });

  runApp(
    MyApp(),
    // DevicePreview(
    //   enabled: !bool.fromEnvironment('dart.vm.product'),
    //   // Enable only in debug/dev
    //   builder: (context) => const MyApp(),
    // ),
  );
}

Future<void> initializeServices() async {
  // Initialize core services
  Get.put(ApiService());
  Get.put(RazorpayService());
  Get.put(NetworkController());
  Get.put(StorageService());

  // Initialize Settings Service and load settings
  final settingsService = Get.put(SettingsService());
  await settingsService.initializeSettings();

  // Handle user session
  final isLoggedIn = StorageService().isLoggedIn;
  if (isLoggedIn) {
    Globals.userData.value = UserModel.fromJson(StorageService().userData);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: GetMaterialApp(
        useInheritedMediaQuery: true,
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        themeMode: ThemeMode.system,
        initialRoute: Routes.splash,
        getPages: AppPages.pages,
        defaultTransition: Transition.fade,
        fallbackLocale: const Locale('en', 'US'),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
