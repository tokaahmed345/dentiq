import 'package:dio/dio.dart';

abstract class ServerFail {
  final String errMessage;

  ServerFail({required this.errMessage});
}


class ServerFailure extends ServerFail {
  ServerFailure({required super.errMessage});

  factory ServerFailure.fromDioExcepiton(
    DioException dioException,
  ) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errMessage: 'Connection timeout');

      case DioExceptionType.sendTimeout:
        return ServerFailure(errMessage: 'Send timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure(errMessage: 'Receive timeout');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          dioException.response!.statusCode!,
          dioException.response!.data,
        );

      case DioExceptionType.badCertificate:
        return ServerFailure(errMessage: 'Bad certificate');

      case DioExceptionType.cancel:
        return ServerFailure(
            errMessage: 'Request to API server was cancelled');

      case DioExceptionType.connectionError:
        return ServerFailure(errMessage: 'Connection error');

      default:
        return ServerFailure(
          errMessage: 'Oops, an unknown error occurred',
        );
    }
  }

  factory ServerFailure.fromResponse(
    int statusCode,
    dynamic response,
  ) {
    if (statusCode >= 400 && statusCode < 500) {
      String? message;

      if (response is Map<String, dynamic>) {
      message = response['errors']?['msg'] ?? 
          response['message'] ?? 
          response['msg'] ?? 
          response['error'] ?? 
          response['errors']?['message'];
    }

      return ServerFailure(
        errMessage: message ?? 'حدث خطأ غير معروف من السيرفر.',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errMessage: 'Internal Server Failure, please try again later.',
      );
    } else {
      return ServerFailure(
        errMessage: 'Unknown error, status code $statusCode',
      );
    }
  }
}


class CustomException implements Exception {
  final String message;

  CustomException({required this.message});

  @override
  String toString() {
    return message;
  }
}
