import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class AuthenticationRepository {
  final Dio dio = ApiClient().dio;

//API Issu
  Future<Map<String, dynamic>> register({required Map<String, String> map}) async {
    final response = await dio.post(
      EndPoints.registerUrl,
      data:map,
      options: Options(extra: {"token": false}),
    );

    return response.data;
  }

  Future<Map<String, dynamic>> login({required FormData formData}) async {
    final response = await dio.post(
      EndPoints.loginUrl,
      data: formData,
      options: Options(extra: {"token": false}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> logOut() async {
    final response = await dio.post(
      EndPoints.logoutUrl,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }
}
