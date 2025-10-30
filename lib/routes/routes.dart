import 'package:get/get.dart';
import 'package:hkdigiskill/app/bindings/onboarding_binding.dart';
import 'package:hkdigiskill/app/bindings/splash_binding.dart';
import 'package:hkdigiskill/modules/onboarding/views/onboarding_screen.dart';
import 'package:hkdigiskill/modules/splash/views/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';
// Add more routes as needed
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingScreen(),
      binding: OnboardingBinding(),
    ),
  ];
}