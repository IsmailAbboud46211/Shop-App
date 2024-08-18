import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/update_profile/repository/update_profile_repo.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  UpdateProfileCubit() : super(UpdateProfileInitial());
  static UpdateProfileCubit get(context) => BlocProvider.of(context);
  final UpdateProfileRepository _repo = UpdateProfileRepository();

  void updateProfile({
    required String email,
    required String name,
    required String phone,
    required String password,
  }) async {
    var formData = FormData.fromMap({
      "email": email,
      "name": name,
      "phone": phone,
      "password": password,
    });

    emit(UpdateProfileProgress());
    try {
      await _repo.updateProfile(formData: formData).then((value) {
        if (value["status"]) {
          emit(UpdateProfileSucceeded(value["message"]));
        } else {
          emit(UpdateProfileFailed(value["message"]));
        }
      });
    } on DioException catch (exception) {
      emit(UpdateProfileFailed(exception.toString()));
    }
  }
}
