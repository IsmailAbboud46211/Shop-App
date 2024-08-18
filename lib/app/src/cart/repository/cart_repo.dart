import 'package:dio/dio.dart';
import 'package:shop_app/core/api/api_client.dart';
import 'package:shop_app/core/api/endpoints.dart';

class CartRepository {
  final Dio dio = ApiClient().dio;

  Future<Map<String, dynamic>> getCartProducts() async {
    final response = await dio.get(
      EndPoints.cartsUrl,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }

  Future<Map<String, dynamic>> toggoleProductCartsState({required productID}) async {
    final response = await dio.post(
      EndPoints.cartsUrl,
      data: productID,
      options: Options(extra: {"token": true}),
    );
    return response.data;
  }
}
