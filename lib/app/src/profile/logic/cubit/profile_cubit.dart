import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/app/src/profile/repository/profile_repo.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/main.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitial());
  final ProfileRepository _repository = ProfileRepository();
  static ProfileCubit get(context) => BlocProvider.of(context);
  UserModel userModel = UserModel(
    id: 0,
    email: "",
    credit: 0,
    points: 0,
    token: '',
    phoneNumber: '',
    userName: '',
    image: '',
  );
  Future getPtofile() async {
    emit(GetProfileProgress());
    try {
      await _repository.getProfile().then((value) {
        if (value["status"]) {
          userModel = UserModel.fromMap(value["data"]);

          hiveDB.putData(
            boxName: BoxesNames.userModel,
            key: KeysNames.user,
            value: userModel,
            boxType: BoxType.USERMODEL,
          );
          emit(GetProfileSucceeded(message: "done"));
        } else {
          emit(GetProfileFailed(message: value["message"]));
        }
      });
    } on DioException catch (exception) {
      emit(GetProfileFailed(message: exception.toString()));
    }
  }
}
