part of 'profile_cubit.dart';

@immutable
sealed class ProfileStates {}

final class ProfileInitial extends ProfileStates {}

class GetProfileProgress extends ProfileStates {}

class GetProfileFailed extends ProfileStates {
  final String message;
  GetProfileFailed({required this.message});
}

class GetProfileSucceeded extends ProfileStates {
  final String message;
  GetProfileSucceeded({required this.message});
}
