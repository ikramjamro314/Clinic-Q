class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String clinicMarketing = '/clinic-marketing';
  static const String roleSelection = '/role-selection';
  static const String walkInEntry = '/walk-in-entry';
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String profileDetails = '/profile-details';
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';
  static const String profileInterestList = '/profile/interest-list';
  static const String profileTermsAndPolicy = '/profile/terms-and-policy';
  static const String profilePrivacyPolicy = '/profile/privacy-policy';
  static const String profileFAQ = '/profile/faq';
  static const String home = '/home';
  static const String clinics = '/clinics';
  static const String doctors = '/doctors';
  static const String doctorFilter = '/doctors/filter';
  static const String doctorProfile = '/doctors/:id';
  static const String writeReview = '/reviews/:id/write';
  static const String allReviews = '/reviews/:id';
  static const String clinicView = '/clinics/:id';
  static const String selectDoctor = '/clinics/:id/select-doctor';
  static const String trackingDebug = '/tracking-debug';
  static const String bookingTokenInfo = '/booking/token-info';
  static const String bookingConfirm = '/booking/confirm';
  static const String bookingSuccess = '/booking/success';
  static const String tracking = '/tracking/:id';

  static String otpVerificationWithParams({required String email}) {
    final queryParams = <String, String>{'email': email};
    return Uri(path: otpVerification, queryParameters: queryParams).toString();
  }

  static String writeReviewWithParams({
    required String entityId,
    required String entityType,
  }) {
    final queryParams = <String, String>{
      'entityId': entityId,
      'entityType': entityType,
    };
    return Uri(path: writeReview, queryParameters: queryParams).toString();
  }

  static String clinicViewWithId({required String clinicId}) {
    return '/clinics/$clinicId';
  }

  static String selectDoctorWithId({required String clinicId}) {
    return '/clinics/$clinicId/select-doctor';
  }
}
