import 'dart:convert';
import 'package:dio/dio.dart';
import 'app_exception.dart';

AppException mapErrorToException(Object error) {
  if (error is AppException) {
    return error;
  }

  if (error is DioException) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutException();
      case DioExceptionType.connectionError:
        return const NetworkException();
      case DioExceptionType.badResponse:
        final response = error.response;
        if (response != null) {
          final statusCode = response.statusCode;
          final data = response.data;

          String? apiErrorMessage;
          String? apiErrorCode;
          if (data is Map<String, dynamic>) {
            apiErrorMessage = data['error'] as String? ?? data['message'] as String?;
            apiErrorCode = data['errorCode'] as String? ?? data['code'] as String?;
          } else if (data is String) {
            try {
              final parsed = jsonDecode(data);
              if (parsed is Map<String, dynamic>) {
                apiErrorMessage = parsed['error'] as String? ?? parsed['message'] as String?;
                apiErrorCode = parsed['errorCode'] as String? ?? parsed['code'] as String?;
              }
            } catch (_) {}
          }

          if (apiErrorCode == 'QUEUE_CLOSED' ||
              apiErrorMessage == 'QUEUE_CLOSED' ||
              (apiErrorMessage != null && apiErrorMessage.contains('QUEUE_CLOSED'))) {
            return const QueueClosedException();
          }

          if (statusCode == 404) {
            return NotFoundException(
              apiErrorMessage ?? "We couldn't find what you were looking for.",
            );
          }
          if (statusCode == 401 || statusCode == 403) {
            return UnknownException(apiErrorMessage ?? 'Unauthorized access.');
          }

          return ServerException(
            apiErrorMessage ?? 'Something went wrong on our end.',
          );
        }
        return const ServerException();
      default:
        return const UnknownException();
    }
  }

  return UnknownException(error.toString());
}
