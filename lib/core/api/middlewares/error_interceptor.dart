import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/authentication/logic/cubit/log_out_cubit.dart';
import 'package:shop_app/main.dart';
import '../custom_errors.dart' as custom_errors;

class ErrorInterceptor extends Interceptor {


  ErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw custom_errors.DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            // throw InvalidLogin(err.requestOptions, err.response);
            throw custom_errors.BadRequestException(
                err.requestOptions, err.response);
          case 401:
            ShopApp.navigatorkey!.currentState!.context
                .read<LogOutCubit>()
                .logOut();
            throw custom_errors.UnauthorizedException(
                err.requestOptions, err.response);
          case 403:
            ShopApp.navigatorkey!.currentState!.context
                .read<LogOutCubit>()
                .logOut();
            throw custom_errors.UnauthorizedException(
                err.requestOptions, err.response);
          case 404:
            throw custom_errors.NotFoundException(
                err.requestOptions, err.response);
          case 409:
            throw custom_errors.ConflictException(
                err.requestOptions, err.response);
          case 500:
            throw custom_errors.InternalServerErrorException(
                err.requestOptions, err.response);
          default:
            throw custom_errors.InternalServerErrorException(
                err.requestOptions, err.response);
        }
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.unknown:
        throw custom_errors.NoInternetConnectionException(err.requestOptions);
      default:
        log(err.response.toString());
        throw custom_errors.NoInternetConnectionException(err.requestOptions);
    }

    return handler.next(err);
  }
}
