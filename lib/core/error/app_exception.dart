sealed class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection.']);
}

class TimeoutException extends AppException {
  const TimeoutException([super.message = 'The request timed out. Please try again.']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Something went wrong on our end.']);
}

class NotFoundException extends AppException {
  const NotFoundException([super.message = "We couldn't find what you were looking for."]);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Couldn\'t load saved data.']);
}

class QueueClosedException extends AppException {
  const QueueClosedException([
    super.message =
        "The queue for today is closed because the doctor's shift has ended. Please pick an upcoming day to book your token.",
  ]);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'Something went wrong. Please try again.']);
}
