import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/app/src/authentication/repository/authenticaton_repo.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/main.dart';

part 'login_states.dart';

class LogInCubit extends Cubit<LogInStates> {
  LogInCubit() : super(LogInInitial());
  final AuthenticationRepository _repository = AuthenticationRepository();
  static LogInCubit get(context) => BlocProvider.of(context);

  Future login({
    required String email,
    required String password,
  }) async {
    emit(LogInProgress());

    var formDate = FormData.fromMap({
      "email": email,
      "password": password,
    });
    try {
      await _repository
          .login(
        formData: formDate,
      )
          .then((value) {
        if (value['status']) {
          UserModel user = UserModel.fromMap(value["data"]);
          hiveDB.putData(
            boxName: BoxesNames.userModel,
            key: KeysNames.user,
            value: user,
            boxType: BoxType.USERMODEL,
          );
          emit(LogInSucceeded("Log in succeeded"));
        } else {
          emit(LogInFailed("Log in failed"));
        }
      });
    } on DioException catch (exception) {
      LogInFailed(exception.toString());
    }
  }
}
