import 'package:shop_app/app/src/categories/data/models/data_model.dart';

class CategoriesDataModel {
  int currentPage = 0;
  List<DataModel> data = [];
  CategoriesDataModel({required this.currentPage, required this.data});
  CategoriesDataModel.fromMap(Map<String, dynamic> map) {
    currentPage = map["current_page"];
    map["data"].forEach((categorie) {
      data.add(DataModel.fromMap(categorie));
    });
  }
}
