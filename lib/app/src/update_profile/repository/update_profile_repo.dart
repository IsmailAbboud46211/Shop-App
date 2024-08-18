import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class UpdateProfileRepository {
  final Dio dio = ApiClient().dio;

  //API Issu
  Future<Map<String, dynamic>> updateProfile(
      {required FormData formData}) async {
    final response = await dio.put(
      EndPoints.updateProfileUrl,
      data: formData,
      options: Options(extra: {"token": true}),
    );

    return response.data;
  }
}
