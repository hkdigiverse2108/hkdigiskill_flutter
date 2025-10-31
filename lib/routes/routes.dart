import 'package:get/get.dart';
import 'package:hkdigiskill/app/bindings/category_binding.dart';
import 'package:hkdigiskill/app/bindings/courses_binding.dart';
import 'package:hkdigiskill/app/bindings/forgot_password_binding.dart';
import 'package:hkdigiskill/app/bindings/home_binding.dart';
import 'package:hkdigiskill/app/bindings/navigation_binding.dart';
import 'package:hkdigiskill/app/bindings/new_password_binding.dart';
import 'package:hkdigiskill/app/bindings/onboarding_binding.dart';
import 'package:hkdigiskill/app/bindings/otp_verify_binding.dart';
import 'package:hkdigiskill/app/bindings/sign_in_binding.dart';
import 'package:hkdigiskill/app/bindings/sign_up_binding.dart';
import 'package:hkdigiskill/app/bindings/splash_binding.dart';
import 'package:hkdigiskill/modules/category/views/category.dart';
import 'package:hkdigiskill/modules/courses/views/courses.dart';
import 'package:hkdigiskill/modules/forgot_password/views/forgot_password.dart';
import 'package:hkdigiskill/modules/home/views/home_screen.dart';
import 'package:hkdigiskill/modules/navigation/views/navigation.dart';
import 'package:hkdigiskill/modules/new_password/views/new_password.dart';
import 'package:hkdigiskill/modules/onboarding/views/onboarding_screen.dart';
import 'package:hkdigiskill/modules/otp_verify/views/otp_verify.dart';
import 'package:hkdigiskill/modules/sign_in/views/sign_in.dart';
import 'package:hkdigiskill/modules/sign_up/views/sign_up.dart';
import 'package:hkdigiskill/modules/splash/views/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerify = '/otp-verify';
  static const String newPassword = '/new-password';
  static const String navigation = '/navigation';
  static const String category = '/category';
  static const String courses = '/courses';
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
    GetPage(
      name: Routes.login,
      page: () => const SignIn(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const SignUp(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPassword(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: Routes.otpVerify,
      page: () => const OtpVerify(),
      binding: OtpVerifyBinding(),
    ),
    GetPage(
      name: Routes.newPassword,
      page: () => const NewPassword(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: Routes.navigation,
      page: () => const Navigation(),
      binding: NavigationBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.category,
      page: () => const Category(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.courses,
      page: () => const Courses(),
      binding: CoursesBinding(),
    ),
  ];
}
