class ApiConstants {
  static const String baseUrl = "https://api.hkdigiskill.com";
  static const String apiVersion = '/v1';

  // Auth
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/user/add';
  static const String verifyOtpEndpoint = '/auth/otp/verify';
  static const String resendOtpEndpoint = '/auth/resend-otp';

  // User
  static const String getUserEndpoint = '/user/';
  static const String updateProfileEndpoint = '/user/update';
  static const String uploadEndpoint = '/upload';
  static const String updatePassword = '/auth/change-password';

  // Banners
  static const String bannersEndpoint = '/hero-banner/all?type=app';

  // Categories
  static const String homeCategoriesEndpoint =
      '/course-category/all?page=1&limit=4';
  static const String categoriesEndpoint = '/course-category/all';
  static const String getCourseFromCategory = '/course/all?courseCategoryId=';
  static const String myCoursesEndpoint = '/course/my-courses';

  // Courses
  static const String coursesEndpoint = '/course/all';
  static const String homeCoursesEndpoint = '/course/all?page=1&limit=4';
  static const String courseByIdEndpoint = '/course/';
  static const String courseFaqsEndpoint = '/faq/all?type=course';
  static const String courseLessonsEndpoint = '/course-lesson/all?courseId=';
  static const String getCurriculumEndpoint =
      '/course-curriculum/all?courseLessonId=';
  static const String coursePaymentEndpoint = '/course/purchase';

  static String getFaqsByCourseIdEndpoint(String id) =>
      '/faq/all?learningCatalogFilter=$id';

  static String getTestimonialsByCourseIdEndpoint(String id) =>
      '/testimonial/all?learningCatalogFilter=$id';

  // Workshops
  static const String workshopsEndpoint = '/workshop/all';
  static const String myWorkshopsEndpoint = '/workshop/my-workshops';
  static const String workshopByIdEndpoint = '/workshop/';
  static const String getWorkshopCurriculumEndpoint =
      '/workshop-curriculum/all?workshopFilter=';
  static const String workshopPaymentEndpoint = '/workshop/purchase';

  static String getFaqsByWorkshopIdEndpoint(String id) =>
      '/faq/all?learningCatalogFilter=$id';

  static String getTestimonialsByWorkshopIdEndpoint(String id) =>
      '/testimonial/all?learningCatalogFilter=$id';

  // Blogs
  static const String blogsEndpoint = '/blog/all';
  static const String homeBlogsEndpoint = '/blog/all?limit=4';

  // Instructors
  static const String instructorsEndpoint = '/instructor/all';

  // Faqs
  static const String homeFaqsEndpoint = '/faq/all?type=home';

  // Testimonials
  static const String testimonialsEndpoint = '/testimonial/all?type=home';
  static const String ratingEndpoint =
      '/testimonial/ratings/summary?learningCatalogFilter=';

  // Gallery
  static const String galleryEndpoint = '/gallery/all';

  // Legality
  static const String legalityEndpoint = '/legality';
  static const String aboutUsEndpoint = '/about-Us';
  static const String newsLetterEndpoint = '/newsletter/add';

  static const String termsConditionEndpoint =
      '/legality?typeFilter=termsCondition';
  static const String privacyPolicyEndpoint =
      '/legality?typeFilter=privacyPolicy';

  // Delete Account
  static const String deleteAccountEndpoint = '/auth/delete-account';

  // coupon
  static const String couponEndpoint = '/coupon-code/validate';
}
