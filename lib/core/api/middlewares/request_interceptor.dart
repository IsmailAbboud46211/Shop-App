import 'package:dio/dio.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/database/keys_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import '../../../main.dart';

class RequestInterceptors extends QueuedInterceptorsWrapper {
  Dio dio;
  RequestInterceptors(this.dio);
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    bool withToken = options.extra['token'] ?? true;
    if (withToken) {
      UserModel userModel = hiveDB.getData(
        boxName: BoxesNames.userModel,
        key: KeysNames.user,
        boxType: BoxType.USERMODEL,
        defaultValue: UserModel(
          id: 0,
          email: "",
          token: "",
          phoneNumber: "",
          userName: "",
          image: "",
          points: 0,
          credit: 0,
        ),
      );
      var token = userModel.token;
      options.headers.addAll({
        "Authorization": token,
        "lang": "en",
      });
    }
    return handler.next(options);
  }
}
