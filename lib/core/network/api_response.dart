import '../error/app_exception.dart';

class ApiResponse {
  /// Validates the API response structure and extracts the `data` portion.
  /// If the API response contains `success: false` or is malformed, it throws a [AppException].
  static dynamic process(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      final success = responseData['success'] as bool? ?? false;
      if (success) {
        return responseData['data'];
      } else {
        final errorCode = responseData['errorCode'] as String? ??
            responseData['code'] as String?;
        final errorMessage =
            responseData['error'] as String? ??
            responseData['message'] as String? ??
            'API operation failed.';

        if (errorCode == 'QUEUE_CLOSED' ||
            errorMessage == 'QUEUE_CLOSED' ||
            errorMessage.contains('QUEUE_CLOSED')) {
          throw const QueueClosedException();
        }

        throw NetworkException(errorMessage);
      }
    }
    throw const NetworkException('Invalid response format received from server.');
  }

  /// Processes the response and extracts the top-level count if present (used in paginated/listed endpoints).
  static int? extractCount(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      return responseData['count'] as int?;
    }
    return null;
  }
}
