class AppException implements Exception {
  final String? message;
  final int? statusCode;

  AppException([this.message, this.statusCode]);

  @override
  String toString() {
    return "$message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([super.message, super.statusCode]);
}

class InternetException extends AppException {
  InternetException([super.message, super.statusCode]);
}

class BadRequestException extends AppException {
  BadRequestException([super.message, super.statusCode]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message, super.statusCode]);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([super.message, super.statusCode]);
}

class InvalidInputException extends AppException {
  InvalidInputException([super.message, super.statusCode]);
}

class InvalidUrlException extends AppException {
  InvalidUrlException([super.message, super.statusCode]);
}

class InternalServerException extends AppException {
  InternalServerException([super.message, super.statusCode]);
}

class ConnectionTimeOutException extends AppException {
  ConnectionTimeOutException([super.message, super.statusCode]);
}

class SendTimeOutException extends AppException {
  SendTimeOutException([super.message, super.statusCode]);
}

class ReceiveTimeOutException extends AppException {
  ReceiveTimeOutException([super.message, super.statusCode]);
}
