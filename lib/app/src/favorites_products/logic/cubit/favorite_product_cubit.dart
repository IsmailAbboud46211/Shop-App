import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/favorites_products/data/model/favorite_product_model.dart';
import 'package:shop_app/app/src/favorites_products/repository/favorites_repo.dart';

part 'favorite_product_state.dart';

class FavoriteProductCubit extends Cubit<FavoriteProductStates> {
  FavoriteProductCubit() : super(FavoriteProductInitial());
  static FavoriteProductCubit get(context) => BlocProvider.of(context);
  FavoritesRepository repo = FavoritesRepository();
  FavoriteProductModel favoriteProductModel = FavoriteProductModel(
    status: false,
    message: "",
    data: Data.fromJson({}),
  );
  Map<int, bool> favoriteProdutsID = {};

  void toggleProductFavorits({required int productID}) async {
    var formData = FormData.fromMap({"product_id": productID});

    emit(ToggleFavoriteProductProgress());
    try {
      await repo.toggoleFavoritProduct(formData: formData).then((value) {
        if (value["status"]) {
          if (favoriteProdutsID[productID] == null) {
            favoriteProdutsID[productID] = true;
          } else {
            favoriteProdutsID[productID] = !favoriteProdutsID[productID]!;
          }
          emit(FavoriteProductToggledSuccessfully());
        } else {
          emit(FailedToggledFavoriteProduct(message: value["message"]));
        }
      });
    } on DioException catch (exception) {
      emit(FailedToggledFavoriteProduct(message: exception.toString()));
    }
  }

  void getFavoriteProducts() async {
    emit(GetFavoriteProductsProgress());
    try {
      await repo.getFavoriteProducts().then((value) {
        favoriteProductModel = FavoriteProductModel.fromJson(value);
        for (var product in favoriteProductModel.data.data) {
          favoriteProdutsID.addAll({
            product.product!.id!: true,
          });
        }
        if (value["status"]) {
          emit(FavoriteProductsFatchedSuccessfully());
        } else {
          emit(FailedFatchFavoriteProducts(message: value["message"]));
        }
      });
    } on DioException catch (exception) {
      emit(FailedFatchFavoriteProducts(message: exception.toString()));
    }
  }
}
