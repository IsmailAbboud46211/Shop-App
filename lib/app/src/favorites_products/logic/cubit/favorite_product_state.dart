part of 'favorite_product_cubit.dart';

@immutable
sealed class FavoriteProductStates {}

final class FavoriteProductInitial extends FavoriteProductStates {}

final class ToggleFavoriteProductProgress extends FavoriteProductStates {}

final class FavoriteProductToggledSuccessfully extends FavoriteProductStates {}

final class FailedToggledFavoriteProduct extends FavoriteProductStates {
  final String message;
  FailedToggledFavoriteProduct({required this.message});
}

final class GetFavoriteProductsProgress extends FavoriteProductStates {}

final class FavoriteProductsFatchedSuccessfully extends FavoriteProductStates {}

final class FailedFatchFavoriteProducts extends FavoriteProductStates {
  final String message;
  FailedFatchFavoriteProducts({required this.message});
}

final class DeleteFavoriteProductsProgress extends FavoriteProductStates {}

final class FavoriteProductsDeletedSuccessfully extends FavoriteProductStates {}

final class FailedDeleteFavoriteProducts extends FavoriteProductStates {
  final String message;
  FailedDeleteFavoriteProducts({required this.message});
}
