import 'dart:convert';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String email;
  @HiveField(2)
  String? token;
  @HiveField(3)
  String userName;
  @HiveField(4)
  String phoneNumber;
  @HiveField(5)
  String image;
  @HiveField(6)
  int points; //Not using in our app just in api
  @HiveField(7)
  int credit; //Not using in our app just in api

  UserModel({
    required this.id,
    required this.email,
    required this.token,
    required this.phoneNumber,
    required this.userName,
    required this.image,
    required this.points,
    required this.credit,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'token': token,
      'phoneNumber': phoneNumber,
      'userName': userName,
      'image': image,
      'points': points,
      'credit': credit,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int,
      email: map['email'] as String,
      token: map['token'] as String?,
      phoneNumber: map['phone'] as String,
      userName: map["name"] as String,
      image: map["image"] as String,
      points: map["points"] as int,
      credit: map["credit"] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'User(id: $id, email: $email, token: $token, phoneNumber: $phoneNumber)';
}
