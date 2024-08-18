part of 'register_cubit.dart';

@immutable
sealed class RegisterStates {}

final class RegisterInitial extends RegisterStates {}

class RegisterProgress extends RegisterStates {}

class RegisterFailed extends RegisterStates {
  final String message;
  RegisterFailed(this.message);
}

class RegisterSucceeded extends RegisterStates {
  final String message;
  RegisterSucceeded(this.message);
}
