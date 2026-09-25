
import 'package:dentiq/core/utils/constant/endpoints.dart';
import 'package:dentiq/core/utils/failure/server_failure.dart';
import 'package:dio/dio.dart';


import 'api_service.dart';

class DioConsumer implements ApiService {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
  }

  @override
  Future get(
    String endPoint, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await dio.get(
        endPoint,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }
@override
Future post(
  String endPoint, {
  Map<String, dynamic>? data,
  Map<String, dynamic>? headers,
  bool isFormData = false,
}) async {
  try {
    final response = await dio.post(
      endPoint,
      data: isFormData
          ? FormData.fromMap(data ?? {})
          : data,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          ...?headers,
        },
      ),
    );

    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE DATA: ${response.data}");

    return response.data;
  } on DioException catch (e) {
  String errorMessage = "Something went wrong. Please try again later.";

  if (e.response?.data != null) {
    final data = e.response!.data;

    if (data is Map && data.containsKey('detail')) {
      errorMessage = data['detail'];
    } else if (data is Map && data.containsKey('message')) {
      errorMessage = data['message'];
    }
  }

  print("❌ API ERROR MESSAGE: $errorMessage");

  throw CustomException(message: errorMessage);
}

}


  @override
  Future patch(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        endPoint,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }

  @override
  Future delete(
    String endPoint, {
    Object? data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        endPoint,
        data:
            isFormData ? FormData.fromMap(data as Map<String, dynamic>) : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }

  @override
  Future put(
    String endPoint, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? headers,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        endPoint,
        data: isFormData ? FormData.fromMap(data) : data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        message: ServerFailure.fromDioExcepiton(e).errMessage,
      );
    }
  }
}
