part of 'log_out_cubit.dart';

@immutable
sealed class LogOutStates {}

final class LogOutInitial extends LogOutStates {}

class LogOutProgress extends LogOutStates {}

class LogOutFailed extends LogOutStates {
  final String message;
  LogOutFailed(this.message);
}

class LogOutSucceeded extends LogOutStates {
  final String message;
  LogOutSucceeded({required this.message});
}
