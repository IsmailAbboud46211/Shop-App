part of 'update_profile_cubit.dart';

@immutable
sealed class UpdateProfileStates {}

final class UpdateProfileInitial extends UpdateProfileStates {}

class UpdateProfileProgress extends UpdateProfileStates {}

class UpdateProfileFailed extends UpdateProfileStates {
  final String message;
  UpdateProfileFailed(this.message);
}

class UpdateProfileSucceeded extends UpdateProfileStates {
  final String message;
  UpdateProfileSucceeded(this.message);
}
