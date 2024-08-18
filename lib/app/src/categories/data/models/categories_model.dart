import 'package:shop_app/app/src/categories/data/models/categories_data_model.dart';

class CategoriesModel {
  bool status = false;
  CategoriesDataModel categoriesDataModel =
      CategoriesDataModel(currentPage: 0, data: []);

  CategoriesModel({
    required this.status,
    required this.categoriesDataModel,
  });
  CategoriesModel.fromMap(Map<String, dynamic> map) {
    status = map["status"];

    categoriesDataModel = CategoriesDataModel.fromMap(map["data"]);
  }
}
