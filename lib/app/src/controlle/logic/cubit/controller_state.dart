part of 'controller_cubit.dart';

@immutable
sealed class ControllerState {}

final class ControllerInitial extends ControllerState {}

final class ChangeNavBarItem extends ControllerState {}
