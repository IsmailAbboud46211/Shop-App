import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_app/app/src/authentication/data/model/user_model.dart';
import 'package:shop_app/core/database/boxes_names.dart';
import 'package:shop_app/core/enum/boxes_type.dart';
import 'package:shop_app/main.dart';

class HiveDB {
  Future initDB() async {
    final documents = await getApplicationDocumentsDirectory();
    Hive.init(documents.path);
    Hive.registerAdapter(UserModelAdapter());
    await Hive.initFlutter();
    await Hive.openBox<UserModel>(BoxesNames.userModel);
    await Hive.openBox(BoxesNames.settings);
  }

  Future putData({
    required String boxName,
    required String key,
    required dynamic value,
    required BoxType boxType,
  }) async {
    Box box = boxType == BoxType.USERMODEL
        ? Hive.box<UserModel>(boxName)
        : Hive.box(boxName);
    box.put(key, value);
  }

  dynamic getData({
    required String boxName,
    required String key,
    required BoxType boxType,
    required dynamic defaultValue,
  }) {
    dynamic data;
    Box box = boxType == BoxType.USERMODEL
        ? Hive.box<UserModel>(boxName)
        : Hive.box(boxName);
    data = box.get(key, defaultValue: defaultValue);
    return data;
  }

  Future clearData({
    required String boxName,
    required BoxType boxType,
  }) async {
    Box box = boxType == BoxType.USERMODEL
        ? Hive.box<UserModel>(boxName)
        : Hive.box(boxName);
    await box.clear();
  }

  Future claerAllData() async {
    hiveDB.claerAllData();
  }
}
