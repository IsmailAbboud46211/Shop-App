import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class ProfileRepository {
  final Dio dio = ApiClient().dio;

  Future<Map<String, dynamic>> getProfile() async {
    final response = await dio.get(
      EndPoints.profileUrl,
      options: Options(extra: {"token": true}),
    );

    return response.data;
  }
}
