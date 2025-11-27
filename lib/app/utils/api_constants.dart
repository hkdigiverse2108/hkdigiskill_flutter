class ApiConstants {
  static const String baseUrl = "http://192.168.29.196:5555";
  static const String apiVersion = '/v1';

  // Auth
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/user/add';
  static const String verifyOtpEndpoint = '/auth/otp/verify';
  static const String resendOtpEndpoint = '/auth/resend-otp';

  // Banners
  static const String bannersEndpoint = '/hero-banner/all?type=app';

  // Categories
  static const String homeCategoriesEndpoint =
      '/course-category/all?page=1&limit=4';
  static const String categoriesEndpoint = '/course-category/all';

  // Courses
  static const String coursesEndpoint = '/course/all';

  // Blogs
  static const String blogsEndpoint = '/blog/all';
  static const String homeBlogsEndpoint = '/blog/all?limit=4';

  // Faqs
  static const String homeFaqsEndpoint = '/faq/all?type=home';

  // Testimonials
  static const String testimonialsEndpoint = '/testimonial/all?type=home';

  // Gallery
  static const String galleryEndpoint = '/gallery/all';
}
