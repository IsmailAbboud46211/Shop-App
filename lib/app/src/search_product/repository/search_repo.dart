import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class SearchRepository {
  final Dio dio = ApiClient().dio;

  Future<Map<String, dynamic>> search({required FormData formData}) async {
    final response = await dio.post(
      EndPoints.searchProductUrl,
      data: formData,
      options: Options(extra: {"token": true}),
    );

    return response.data;
  }
}
