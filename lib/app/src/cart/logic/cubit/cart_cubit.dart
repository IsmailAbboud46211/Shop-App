import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/cart/data/cart_model.dart';
import 'package:shop_app/app/src/cart/repository/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitial());
  static CartCubit get(context) => BlocProvider.of(context);
  CartModel cartModel = CartModel(
      status: false,
      message: "",
      data: Data.fromJson(
        {},
      ));
  final CartRepository _repo = CartRepository();
  Map<int, bool> cartProdutsID = {};
  getCartProducts() async {
    emit(GetCartProductsProgress());
    try {
      await _repo.getCartProducts().then(
        (value) {
          cartModel = CartModel.fromJson(value);
          for (var product in cartModel.data.cartItems) {
            cartProdutsID.addAll({
              product.product!.id!: true,
            });
          }
          if (value["status"]) {
            emit(CartProductsFatchedSuccessfully());
          } else {
            emit(FailedFatchCartProducts(message: "There is an issue"));
          }
        },
      );
    } on DioException catch (exception) {
      emit(FailedFatchCartProducts(message: exception.toString()));
    }
  }

  toggoleCartProduct({required productID}) async {
    FormData formData = FormData.fromMap({"product_id": productID});
    emit(ToggleCartProductStateProgress());
    try {
      await _repo.toggoleProductCartsState(productID: formData).then(
        (value) {
          if (value["status"]) {
            if (cartProdutsID[productID] == null) {
              cartProdutsID[productID] = true;
            } else {
              cartProdutsID[productID] = !cartProdutsID[productID]!;
            }
            emit(CartProductStateToggledSuccessfully());
          } else {
            emit(FailedToggledCartProductState(message: "There is an issue"));
          }
        },
      );
    } on DioException catch (exception) {
      emit(FailedToggledCartProductState(message: exception.toString()));
    }
  }
}
