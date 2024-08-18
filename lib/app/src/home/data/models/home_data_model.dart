import 'package:shop_app/app/src/home/data/models/banner_model.dart';
import 'package:shop_app/app/src/home/data/models/product_model.dart';

class HomeDataModel {
  List<BannerModel> bannersList = [];
  List<Product> productsList = [];

  HomeDataModel({required this.bannersList, required this.productsList});

  HomeDataModel.fromMap({required Map<String, dynamic> map}) {
    map["banners"].forEach((jsonBanner) {
      bannersList.add(BannerModel.fromMap(jsonBanner));
    });
    map["products"].forEach((jsonProduct) {
      productsList.add(Product.fromMap(jsonProduct));
    });
  }
}
