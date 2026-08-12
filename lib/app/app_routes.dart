class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String clinicMarketing = '/clinic-marketing';
  static const String roleSelection = '/role-selection';
  static const String walkInEntry = '/walk-in-entry';
  static const String login = '/login';
  static const String otpVerification = '/otp-verification';
  static const String profile = '/profile';
  static const String home = '/home';
  static const String clinics = '/clinics';
  static const String doctors = '/doctors';
  static const String doctorFilter = '/doctors/filter';
  static const String doctorProfile = '/doctors/:id';
  static const String writeReview = '/reviews/:id/write';
  static const String allReviews = '/reviews/:id';
  static const String clinicView = '/clinics/:id';
  static const String selectDoctor = '/clinics/:id/select-doctor';

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
