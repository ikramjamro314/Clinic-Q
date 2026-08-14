import 'package:clinic_q/core/error/exceptions.dart';

class ApiResponse {
  /// Validates the API response structure and extracts the `data` portion.
  /// If the API response contains `success: false` or is malformed, it throws a [NetworkException].
  static dynamic process(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final success = responseData['success'] as bool? ?? false;
      if (success) {
        return responseData['data'];
      } else {
        final errorMessage = responseData['error'] as String? ?? 'API operation failed.';
        throw NetworkException(errorMessage);
      }
    }
    throw NetworkException('Invalid response format received from server.');
  }

  /// Processes the response and extracts the top-level count if present (used in paginated/listed endpoints).
  static int? extractCount(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      return responseData['count'] as int?;
    }
    return null;
  }
}
