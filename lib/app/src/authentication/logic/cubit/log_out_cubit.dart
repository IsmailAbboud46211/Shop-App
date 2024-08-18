import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/authentication/repository/authenticaton_repo.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/main.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutStates> {
  LogOutCubit() : super(LogOutInitial());
  final AuthenticationRepository _repository = AuthenticationRepository();
  static LogOutCubit get(context) => BlocProvider.of(context);

  Future logOut() async {
    emit(LogOutProgress());
    try {
      _repository.logOut().then((value) {
        if (value["status"]) {
          hiveDB.clearData(
            boxName: BoxesNames.userModel,
            boxType: BoxType.USERMODEL,
          );
          hiveDB.clearData(
            boxName: BoxesNames.settings,
            boxType: BoxType.STRYING,
          );

          emit(LogOutSucceeded(message: "LogedOut"));
        } else {
          emit(LogOutFailed(value["message"]));
        }
      });
    } catch (exception) {
      emit(LogOutFailed(exception.toString()));
    }
  }
}
