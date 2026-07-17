class AppException implements Exception {
  final String message;

  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException() : super('No Internet Connection');
}

class TimeoutException extends AppException {
  TimeoutException() : super('Request Timeout');
}

class ServerException extends AppException {
  ServerException() : super('Server Error');
}

class UnknownException extends AppException {
  UnknownException() : super('Something went wrong');
}
