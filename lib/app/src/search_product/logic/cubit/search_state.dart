part of 'search_cubit.dart';

@immutable
sealed class SearchStates {}

final class SearchInitial extends SearchStates {}

final class SearchProgress extends SearchStates {}

final class NoItemFound extends SearchStates {}

final class SearchFailed extends SearchStates {
  final String message;
  SearchFailed({required this.message});
}

final class SearchSucceeded extends SearchStates {
  final String message;
  SearchSucceeded({required this.message});
}
