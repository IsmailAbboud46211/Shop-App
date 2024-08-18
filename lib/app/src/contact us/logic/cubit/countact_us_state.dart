part of 'countact_us_cubit.dart';

@immutable
sealed class ContactUsState {}

final class ContactUsInitial extends ContactUsState {}

final class LoadingContactUS  extends ContactUsState {}

final class ContactUsLoadedSuccessfully extends ContactUsState {}

final class FailedToLoadedContactUs extends ContactUsState {
  final String message;
  FailedToLoadedContactUs({required this.message});
}
