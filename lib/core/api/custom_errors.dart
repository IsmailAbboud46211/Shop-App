import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return response!.data["error"];
    // return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Something went wrong, Please retry later';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return response!.data["error"];
    // return 'Conflict occured';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return response!.data["error"];
    // return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return response!.data["error"];
    // return 'Sorry, this record no longer exists';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() {
    return 'No internet connection detected, Please check your network connection';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has Timeout, Please try again';
  }
}

class CustomException extends DioException {
  CustomException(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return response!.data["error"];
    // return 'Custom Exception';
  }
}

class InvalidLogin extends DioException {
  InvalidLogin(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'Invalid login';
  }
}

class InvalidPermission extends DioException {
  InvalidPermission(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Invalid permission';
  }
}

class IncorrectOldPassword extends DioException {
  IncorrectOldPassword(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Incorrect old password';
  }
}

class InvalidData extends DioException {
  InvalidData(RequestOptions r, Response<dynamic>? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return 'Incorrect dates, Try again with different dates';
  }
}
