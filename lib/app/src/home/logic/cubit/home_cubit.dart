import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/home/data/models/home_data_model.dart';
import 'package:shop_app/app/src/home/data/models/home_model.dart';
import 'package:shop_app/app/src/home/repository/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);
  final HomeRepository _repo = HomeRepository();
  HomeModel homeModel = HomeModel(
    status: false,
    data: HomeDataModel(bannersList: [], productsList: []),
  );

  void getHomeData() async {
    emit(LodingHomeData());
    try {
      await _repo.getHomeData().then((value) {
        homeModel = HomeModel.fromMap(map: value);

        if (homeModel.status) {
          emit(HomeDataFetchedSuccessfully());
        } else {
          emit(FailedToFetchData(message: value["message"]));
        }
      });
    } on DioException catch (exception) {
      emit(FailedToFetchData(message: exception.toString()));
    }
  }
}
