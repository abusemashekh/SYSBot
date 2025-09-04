import 'package:dio/dio.dart';
import 'package:sysbot3/backend/api_exceptions.dart';
import 'package:sysbot3/utils/functions/common_fun.dart';

/// Handle exceptions based on status code
class ErrorInterceptor extends Interceptor {
  String message = 'message';
  final Dio dio;
  ErrorInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        logPrint(
            message: "${err.response?.statusCode} : ${err.response?.data}",
            isError: true);
        throw ConnectionTimeOutException(
            err.response?.data[message], err.response?.statusCode);
      case DioExceptionType.sendTimeout:
        logPrint(
            message: "${err.response?.statusCode} : ${err.response?.data}");
        throw SendTimeOutException(
            err.response?.data[message], err.response?.statusCode);
      case DioExceptionType.receiveTimeout:
        logPrint(
            message: "${err.response?.statusCode} : ${err.response?.data}",
            isError: true);
        throw ReceiveTimeOutException(
            err.response?.data[message], err.response?.statusCode);
      case DioExceptionType.badResponse:
        logPrint(
            message: "${err.response?.statusCode} : ${err.response?.data}",
            isError: true);

        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(
                err.response?.data[message], err.response?.statusCode);
          case 401:
            throw UnauthorisedException(
                err.response?.data[message], err.response?.statusCode);
          case 403:
            throw BadRequestException(
                err.response?.data[message], err.response?.statusCode);
          case 404:
            throw NotFoundException(
                err.response?.data[message], err.response?.statusCode);
          case 500:
            throw InternalServerException(
                err.response?.data[message], err.response?.statusCode);
        }
        break;
      case DioExceptionType.unknown:
        logPrint(
            message: "${err.response?.statusCode} : ${err.response?.data}",
            isError: true);
        throw InternetException(
            err.response?.data[message], err.response?.statusCode);
      case DioExceptionType.connectionError:
        logPrint(message: "Connection Error", isError: true);
        throw InternetException('No Internet', err.response?.statusCode);
      default:
        logPrint(
            message: "${err.response?.statusCode} : ${err.response?.data}",
            isError: true);
        throw FetchDataException(
            'Error accrued while Communication with Server with StatusCode : ${err.response?.statusCode}');
    }
    return handler.next(err);
  }
}
