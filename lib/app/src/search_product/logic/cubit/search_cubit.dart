import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/search_product/data/model/search_model.dart';
import 'package:shop_app/app/src/search_product/repository/search_repo.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitial());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel searchModel = SearchModel.fromJson({});
  final SearchRepository _repo = SearchRepository();

  void search({required String text}) async {
    emit(SearchProgress());
    var formData = FormData.fromMap({"text": text});
    try {
      await _repo.search(formData: formData).then((value) {
        searchModel = SearchModel.fromJson(value);
        if (value["status"]) {
          if (searchModel.data!.data!.isEmpty) {
            emit(NoItemFound());
          }
          emit(SearchSucceeded(message: "Data Featched"));
        } else {
          emit(SearchFailed(message: "Error"));
        }
      });
    } on DioException catch (exception) {
      emit(SearchFailed(message: exception.toString()));
    }
  }
}
