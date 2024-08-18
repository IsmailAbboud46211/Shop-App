import 'package:shop_app/app/src/home/data/models/home_data_model.dart';

class HomeModel {
  bool status;
  HomeDataModel data;

  HomeModel({required this.status, required this.data});

  factory HomeModel.fromMap({required Map<String, dynamic> map}) {
    return HomeModel(
      status: map["status"] as bool,
      data: HomeDataModel.fromMap(map: map["data"]),
    );
  }
}
