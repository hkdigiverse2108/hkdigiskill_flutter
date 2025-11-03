import 'package:get/get.dart';
import 'package:hkdigiskill/app/bindings/about_us_binding.dart';
import 'package:hkdigiskill/app/bindings/blog_binding.dart';
import 'package:hkdigiskill/app/bindings/blog_details_binding.dart';
import 'package:hkdigiskill/app/bindings/category_binding.dart';
import 'package:hkdigiskill/app/bindings/change_password_binding.dart';
import 'package:hkdigiskill/app/bindings/chat_binding.dart';
import 'package:hkdigiskill/app/bindings/chats_binding.dart';
import 'package:hkdigiskill/app/bindings/contact_us_binding.dart';
import 'package:hkdigiskill/app/bindings/course_details_binding.dart';
import 'package:hkdigiskill/app/bindings/courses_binding.dart';
import 'package:hkdigiskill/app/bindings/faq_binding.dart';
import 'package:hkdigiskill/app/bindings/forgot_password_binding.dart';
import 'package:hkdigiskill/app/bindings/gallery_binding.dart';
import 'package:hkdigiskill/app/bindings/home_binding.dart';
import 'package:hkdigiskill/app/bindings/navigation_binding.dart';
import 'package:hkdigiskill/app/bindings/new_password_binding.dart';
import 'package:hkdigiskill/app/bindings/notification_binding.dart';
import 'package:hkdigiskill/app/bindings/onboarding_binding.dart';
import 'package:hkdigiskill/app/bindings/otp_verify_binding.dart';
import 'package:hkdigiskill/app/bindings/pay_binding.dart';
import 'package:hkdigiskill/app/bindings/privacy_policy_binding.dart';
import 'package:hkdigiskill/app/bindings/profile_binding.dart';
import 'package:hkdigiskill/app/bindings/sign_in_binding.dart';
import 'package:hkdigiskill/app/bindings/sign_up_binding.dart';
import 'package:hkdigiskill/app/bindings/splash_binding.dart';
import 'package:hkdigiskill/app/bindings/terms_condition_binding.dart';
import 'package:hkdigiskill/app/bindings/testimonials_binding.dart';
import 'package:hkdigiskill/app/bindings/top_instructors_binding.dart';
import 'package:hkdigiskill/app/bindings/video_binding.dart';
import 'package:hkdigiskill/modules/app_info/views/about_us_page.dart';
import 'package:hkdigiskill/modules/app_info/views/contact_us_page.dart';
import 'package:hkdigiskill/modules/app_info/views/privacy_policy_page.dart';
import 'package:hkdigiskill/modules/app_info/views/terms_condition_page.dart';
import 'package:hkdigiskill/modules/blog/views/blog_details.dart';
import 'package:hkdigiskill/modules/blog/views/blogs.dart';
import 'package:hkdigiskill/modules/category/views/category.dart';
import 'package:hkdigiskill/modules/chat/views/chat.dart';
import 'package:hkdigiskill/modules/chat/views/chats.dart';
import 'package:hkdigiskill/modules/courses/views/course_details_screen.dart';
import 'package:hkdigiskill/modules/courses/views/courses.dart';
import 'package:hkdigiskill/modules/courses/views/view_all_course.dart';
import 'package:hkdigiskill/modules/faq/views/faq.dart';
import 'package:hkdigiskill/modules/forgot_password/views/forgot_password.dart';
import 'package:hkdigiskill/modules/gallery/views/gallery.dart';
import 'package:hkdigiskill/modules/gallery/views/gallery_details.dart';
import 'package:hkdigiskill/modules/home/views/home_screen.dart';
import 'package:hkdigiskill/modules/instructor/views/top_instructors_page.dart';
import 'package:hkdigiskill/modules/navigation/views/navigation.dart';
import 'package:hkdigiskill/modules/new_password/views/new_password.dart';
import 'package:hkdigiskill/modules/notification/views/notification.dart';
import 'package:hkdigiskill/modules/onboarding/views/onboarding_screen.dart';
import 'package:hkdigiskill/modules/otp_verify/views/otp_verify.dart';
import 'package:hkdigiskill/modules/profile/views/change_password.dart';
import 'package:hkdigiskill/modules/profile/views/profile.dart';
import 'package:hkdigiskill/modules/profile/views/update_profile.dart';
import 'package:hkdigiskill/modules/sign_in/views/sign_in.dart';
import 'package:hkdigiskill/modules/sign_up/views/sign_up.dart';
import 'package:hkdigiskill/modules/splash/views/splash_screen.dart';
import 'package:hkdigiskill/modules/testimonials/views/testimonials.dart';
import 'package:hkdigiskill/modules/workshops/bindings/workshop_details_binding.dart';
import 'package:hkdigiskill/modules/workshops/bindings/workshops_binding.dart';
import 'package:hkdigiskill/modules/workshops/views/workshop_details_screen.dart';
import 'package:hkdigiskill/modules/workshops/views/workshops.dart';
import 'package:hkdigiskill/shared/views/pay.dart';
import 'package:hkdigiskill/shared/views/video_screen.dart';

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
  static const String courseDetails = '/course-details';
  static const String video = '/video';
  static const String pay = '/pay';
  static const String profile = '/profile';
  static const String topInstructors = '/top-instructors';
  static const String blogs = '/blogs';
  static const String blogDetails = '/blog-details';
  static const String faq = '/faq';
  static const String gallery = '/gallery';
  static const String galleryDetails = '/gallery-details';
  static const String testimonials = '/testimonials';
  static const String updateProfile = '/update-profile';
  static const String changePassword = '/change-password';
  static const String aboutUs = '/about-us';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsCondition = '/terms-condition';
  static const String contactUs = '/contact-us';
  static const String workshops = '/workshops';
  static const String workshopDetails = '/workshop-details';
  static const String chats = '/chats';
  static const String chatMassage = '/chat-massage';
  static const String notification = '/notification';
  static const String viewAllCourse = '/view-all-course';
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
    GetPage(
      name: Routes.courseDetails,
      page: () => const CourseDetailsScreen(),
      binding: CourseDetailsBinding(),
    ),
    GetPage(
      name: Routes.video,
      page: () => VideoDetailPage(),
      binding: VideoBinding(),
    ),
    GetPage(name: Routes.pay, page: () => const Pay(), binding: PayBinding()),
    GetPage(
      name: Routes.profile,
      page: () => const ProfileMenuPage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.topInstructors,
      page: () => const TopInstructorsPage(),
      binding: TopInstructorsBinding(),
    ),
    GetPage(
      name: Routes.blogs,
      page: () => const BlogsPage(),
      binding: BlogBinding(),
    ),
    GetPage(
      name: Routes.blogDetails,
      page: () => const BlogDetailsPage(),
      binding: BlogDetailsBinding(),
    ),
    GetPage(name: Routes.faq, page: () => const Faq(), binding: FaqBinding()),
    GetPage(
      name: Routes.gallery,
      page: () => const GalleryPage(),
      binding: GalleryBinding(),
    ),
    GetPage(
      name: Routes.testimonials,
      page: () => const TestimonialsPage(),
      binding: TestimonialsBinding(),
    ),
    GetPage(name: Routes.updateProfile, page: () => const UpdateProfilePage()),
    GetPage(
      name: Routes.changePassword,
      page: () => const ChangePasswordPage(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: Routes.aboutUs,
      page: () => const AboutUsPage(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: Routes.privacyPolicy,
      page: () => const PrivacyPolicyPage(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: Routes.termsCondition,
      page: () => const TermsConditionPage(),
      binding: TermsConditionBinding(),
    ),
    GetPage(
      name: Routes.contactUs,
      page: () => const ContactUsPage(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: Routes.workshops,
      page: () => const Workshops(),
      binding: WorkshopsBinding(),
    ),
    GetPage(
      name: Routes.workshopDetails,
      page: () => const WorkshopDetailsScreen(),
      binding: WorkshopDetailsBinding(),
    ),
    GetPage(
      name: Routes.chats,
      page: () => const Chats(),
      binding: ChatsBinding(),
    ),
    GetPage(
      name: Routes.chatMassage,
      page: () => const Chat(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: Routes.notification,
      page: () => const Notification(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.viewAllCourse,
      page: () => const ViewAllCourse(),
      // binding: ViewAllCourseBinding(),
    ),
  ];
}
