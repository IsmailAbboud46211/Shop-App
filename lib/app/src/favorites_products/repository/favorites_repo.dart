import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class FavoritesRepository {
  final Dio dio = ApiClient().dio;
  Future<Map<String, dynamic>> toggoleFavoritProduct({
    required FormData formData,
  }) async {
    final response = await dio.post(
      EndPoints.favoriteUrl,
      data: formData,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> getFavoriteProducts() async {
    final response = await dio.get(
      EndPoints.favoriteUrl,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }
}
