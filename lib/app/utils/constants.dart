class AppConstants {
  // App metadata
  static const String appName = 'HK Digital Skills';
  static const String appVersion = '1.0.0';

  // API endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';

  // API endpoints
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String coursesEndpoint = '/courses';

  // Shared Preferences keys
  static const String authTokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userDataKey = 'user_data';
  static const String isDarkModeKey = 'is_dark_mode';

  // Assets paths
  static const String logoPath = 'assets/images/logo.png';
  static const String placeholderImage = 'assets/images/placeholder.jpg';

  // Animation durations
  static const Duration defaultDuration = Duration(milliseconds: 300);
  static const Duration mediumDuration = Duration(milliseconds: 500);
  static const Duration longDuration = Duration(seconds: 1);

  // Form validation messages
  static const String emailRequired = 'Please enter your email';
  static const String validEmail = 'Please enter a valid email';
  static const String passwordRequired = 'Please enter your password';
  static const String passwordMinLength = 'Password must be at least 6 characters';
  static const String confirmPasswordMatch = 'Passwords do not match';
  static const String nameRequired = 'Please enter your name';

  // Error messages
  static const String connectionError = 'No internet connection';
  static const String serverError = 'Server error. Please try again later.';
  static const String unknownError = 'Something went wrong. Please try again.';

  // Success messages
  static const String loginSuccess = 'Logged in successfully';
  static const String registerSuccess = 'Account created successfully';
  static const String profileUpdateSuccess = 'Profile updated successfully';

  // Local storage
  static const String localeKey = 'locale';
  static const String defaultLocale = 'en';

  // Pagination
  static const int defaultPageSize = 10;

  // App settings
  static const bool isDemoMode = false; // Set to true for demo mode
}