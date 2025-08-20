/// Authentication-related constants
class AuthConstants {
  // API Endpoints
  static const String loginEndpoint = 'auth/login';
  static const String logoutEndpoint = 'auth/logout';
  static const String getCurrentUserEndpoint = 'auth/me';
  static const String registerEndpoint = 'users';
  static const String forgotPasswordEndpoint = 'auth/forgot-password';
  static const String resetPasswordEndpoint = 'auth/reset-password';
  static const String changePasswordEndpoint = 'auth/change-password';

  // User Roles
  static const String userRole = 'USER';
  static const String adminRole = 'ADMIN';
  static const String partnerRole = 'PARTNER';

  // Storage Keys
  static const String userStorageKey = 'user';
  static const String rememberMeKey = 'rememberMe';
  static const String sessionCookieKey = 'session_cookie';

  // Validation Rules
  static const int minPasswordLength = 8;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Error Messages
  static const String emailRequiredMessage = 'Email is required';
  static const String emailInvalidMessage =
      'Please enter a valid email address';
  static const String passwordRequiredMessage = 'Password is required';
  static const String passwordMinLengthMessage =
      'Password must be at least 8 characters';
  static const String nameRequiredMessage = 'Name is required';
  static const String nameMinLengthMessage =
      'Name must be at least 2 characters';
  static const String termsRequiredMessage =
      'Please agree to Terms and Conditions';
  static const String passwordMismatchMessage = 'Passwords do not match';

  // Success Messages
  static const String loginSuccessMessage = 'Login successful';
  static const String logoutSuccessMessage = 'Logout successful';
  static const String registrationSuccessMessage =
      'Account created successfully';
  static const String passwordResetSuccessMessage =
      'Password reset successfully';
  static const String passwordChangeSuccessMessage =
      'Password changed successfully';

  // Route Names
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String resetPasswordRoute = '/reset-password';
  static const String userHomeRoute = '/user/home';
  static const String adminDashboardRoute = '/admin/dashboard';
  static const String unauthorizedRoute = '/unauthorized';
}
