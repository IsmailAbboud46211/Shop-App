import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/app/src/authentication/repository/authenticaton_repo.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/main.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitial());
  final AuthenticationRepository _repository = AuthenticationRepository();
  static RegisterCubit get(context) => BlocProvider.of(context);

  Future register({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) async {
    emit(RegisterProgress());
    var map = {
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
    };
    try {
      await _repository
          .register(
        map: map,
      )
          .then((value) {
        if (value["status"]) {
          UserModel user = UserModel.fromMap(value["data"]);
          hiveDB.putData(
            boxName: BoxesNames.userModel,
            key: KeysNames.user,
            value: user,
            boxType: BoxType.USERMODEL,
          );
          emit(RegisterSucceeded(value["Register succeeded"]));
        } else {
          emit(RegisterFailed(value['Register failed']));
        }
      });
    } on DioException catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
