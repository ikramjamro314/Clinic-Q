class AuthException implements Exception {
  final String message;
  AuthException(this.message);
  @override
  String toString() => message;
}

class UserNotFoundException extends AuthException {
  UserNotFoundException(super.message);
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException(super.message);
}

class NetworkException extends AuthException {
  NetworkException([
    super.message = 'Network error. Please check your connection.',
  ]);
}

class ValidationException extends AuthException {
  ValidationException(super.message);
}

class OtpVerificationException extends AuthException {
  OtpVerificationException(super.message);
}

class EmailNotConfirmedException extends AuthException {
  EmailNotConfirmedException([
    super.message = 'Please verify your email before signing in.',
  ]);
}

class WeakPasswordException extends AuthException {
  WeakPasswordException(super.message);
}
