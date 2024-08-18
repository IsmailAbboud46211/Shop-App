part of 'categories_cubit.dart';

@immutable
sealed class CategoriesStates {}

final class CategoriesInitial extends CategoriesStates {}

final class LodingCategoriesData extends CategoriesStates {}

final class CategoriesDataFetchedSuccessfully extends CategoriesStates {}

final class FailedToFetchCategoriesData extends CategoriesStates {
  final String message;
  FailedToFetchCategoriesData({required this.message});
}
