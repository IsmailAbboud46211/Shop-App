import 'package:dio/dio.dart';

class ResponseInterceptor extends Interceptor {
  Dio dio;

  ResponseInterceptor(this.dio);
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}
