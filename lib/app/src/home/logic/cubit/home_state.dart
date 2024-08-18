part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LodingHomeData extends HomeState {}

final class HomeDataFetchedSuccessfully extends HomeState {}

final class FailedToFetchData extends HomeState {
  final String message;
  FailedToFetchData({required this.message});
}
