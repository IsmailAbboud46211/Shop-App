part of 'login_cubit.dart';

sealed class LogInStates {}

class LogInInitial extends LogInStates {}

class LogInProgress extends LogInStates {}

class LogInFailed extends LogInStates {
  final String message;
  LogInFailed(this.message);
}

class LogInSucceeded extends LogInStates {
  final String message;
  LogInSucceeded(this.message);
}
