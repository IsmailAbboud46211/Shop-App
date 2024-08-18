import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class CategoriesRepository {
  final Dio dio = ApiClient().dio;
  Future<Map<String, dynamic>> getCategoriesData() async {
    final response = await dio.get(
      EndPoints.categoriesUrl,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }
}
