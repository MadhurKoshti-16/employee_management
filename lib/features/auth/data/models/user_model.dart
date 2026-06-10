import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/app_user.dart';

class UserModel extends AppUser {
  const UserModel({
    required super.uid,
    required super.email,
  });

  factory UserModel.fromFirebaseUser(
    User user,
  ) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      uid: json['uid'] ?? '',
      email: json['email'] ?? '',
    );
  }
}