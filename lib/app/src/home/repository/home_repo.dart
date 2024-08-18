import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class HomeRepository {
  final Dio dio = ApiClient().dio;
  Future<Map<String, dynamic>> getHomeData() async {
    final response = await dio.get(
      EndPoints.homeUrl,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }
}
