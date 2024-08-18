import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/main.dart';

part 'start_app_state.dart';

class StartAppCubit extends Cubit<StartAppStates> {
  StartAppCubit() : super(StartAppInitial());
  static StartAppCubit get(BuildContext context) => BlocProvider.of(context);
  bool _checkUserToken() {
    UserModel userModel = hiveDB.getData(
      boxName: BoxesNames.userModel,
      key: KeysNames.user,
      boxType: BoxType.USERMODEL,
      defaultValue: UserModel(
        id: 0,
        email: "",
        token: null,
        phoneNumber: "",
        userName: "",
        image: "",
        points: 0,
        credit: 0,
      ),
    );
    String? token = userModel.token;
    if (token == null) {
      return false;
    }
    return true;
  }

  bool _isOnBordingSkipped() {
    bool isOnBordingSkipped = hiveDB.getData(
      boxName: BoxesNames.settings,
      key: KeysNames.skipOnBording,
      boxType: BoxType.BOOLEAN,
      defaultValue: false,
    );
    //  log(isOnBordingSkipped.toString());
    return isOnBordingSkipped;
  }

  void startApp() async {
    bool onBordingState = _isOnBordingSkipped();
    final bool userHasToken = _checkUserToken();
    if (userHasToken) {
      emit(AuthenticatedUser());
    } else {
      if (onBordingState) {
        emit(UnAuthenticatedUser());
      } else {
        emit(ShowOnBoarding());
      }
    }
  }

  void kickOutTheUser() => emit(UnAuthenticatedUser());

  void userLogedOut() => emit(UserLogedOut());

  void userVrified() => emit(AuthenticatedUser());
}
