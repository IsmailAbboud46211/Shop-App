// ignore_for_file: must_be_immutable

part of 'cart_cubit.dart';

@immutable
sealed class CartStates {}

final class CartInitial extends CartStates {}

final class GetCartProductsProgress extends CartStates {}

final class CartProductsFatchedSuccessfully extends CartStates {}

final class FailedFatchCartProducts extends CartStates {
  var message = "";
  FailedFatchCartProducts({required this.message});
}

final class ToggleCartProductStateProgress extends CartStates {}

final class CartProductStateToggledSuccessfully extends CartStates {}

final class FailedToggledCartProductState extends CartStates {
  var message = "";
  FailedToggledCartProductState({required this.message});
}
