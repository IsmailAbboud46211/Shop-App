import 'package:dio/dio.dart';
import 'package:shop_app/core/api/endpoints.dart';
import 'package:shop_app/core/api/middlewares/error_interceptor.dart';
import 'package:shop_app/core/api/middlewares/logger_interceptor.dart';
import 'package:shop_app/core/api/middlewares/request_interceptor.dart';

class ApiClient {
  final dio = getDio();
  ApiClient._internal();

  static final _singleton = ApiClient._internal();

  factory ApiClient() => _singleton;

  static Dio getDio() {
    var dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );
    dio.interceptors.addAll({
      LoggerInterceptor(
        logRequestTimeout: false,
        logRequestHeaders: true,
        logResponseHeaders: false,
      ),
      RequestInterceptors(dio),
      ErrorInterceptor()
    });
    return dio;
  }
}
