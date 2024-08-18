import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/categories/data/models/categories_data_model.dart';
import 'package:shop_app/app/src/categories/data/models/categories_model.dart';
import 'package:shop_app/app/src/categories/repository/categories_repo.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesStates> {
  CategoriesCubit() : super(CategoriesInitial());
  static CategoriesCubit get(context) => BlocProvider.of(context);
  final CategoriesRepository _repo = CategoriesRepository();
  CategoriesModel categoriesModel = CategoriesModel(
    status: false,
    categoriesDataModel: CategoriesDataModel(currentPage: 0, data: []),
  );

  void getCategories() async {
    emit(LodingCategoriesData());
    try {
      await _repo.getCategoriesData().then((value) {
        categoriesModel = CategoriesModel.fromMap(value);
        if (categoriesModel.status) {
          emit(CategoriesDataFetchedSuccessfully());
        } else {
          emit(FailedToFetchCategoriesData(message: value["message"]));
        }
      });
    } on DioException catch (exception) {
      emit(FailedToFetchCategoriesData(message: exception.toString()));
    }
  }
}
