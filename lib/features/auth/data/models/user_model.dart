import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
      {required super.name, required super.email, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
