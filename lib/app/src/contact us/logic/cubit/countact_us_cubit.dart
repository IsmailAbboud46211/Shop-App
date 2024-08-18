import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/app/src/contact%20us/data/contact_us_model.dart';
import 'package:shop_app/app/src/contact%20us/repository/contact_us_repository.dart';

part 'countact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsInitial());
  static ContactUsCubit get(context) => BlocProvider.of(context);
  final _repo = ContactUsRepository();

  var contactUsModel = ContactUsModel(
    status: true,
    message: " ",
    data: Data.fromJson({}),
  );
  void getContactUsData() async {
    emit(LoadingContactUS());
    try {
      await _repo.getContatctUsData().then((value) {
        contactUsModel = ContactUsModel.fromJson(map: value);
        if (contactUsModel.status) {
          emit(ContactUsLoadedSuccessfully());
          log("from Cubit");
          log(contactUsModel.data.toString());
        } else {
          emit(FailedToLoadedContactUs(
              message: value["Failed to loaded the  data"]));
        }
      });
    } on DioException catch (exception) {
      emit(FailedToLoadedContactUs(message: exception.toString()));
    }
  }
}
