part of 'start_app_cubit.dart';

@immutable
sealed class StartAppStates {}

final class StartAppInitial extends StartAppStates {}

final class UnAuthenticatedUser extends StartAppStates {}

final class AuthenticatedUser extends StartAppStates {}

final class ShowOnBoarding extends StartAppStates {}

final class UserLogedOut extends StartAppStates {}
