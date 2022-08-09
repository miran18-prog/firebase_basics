// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String username;
  final String email;
  final String gender;
  final String skill;
  UserModel({
    required this.username,
    required this.email,
    required this.gender,
    required this.skill,
  });

  UserModel copyWith({
    String? username,
    String? email,
    String? gender,
    String? skill,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      skill: skill ?? this.skill,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'gender': gender,
      'skill': skill,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'] as String,
      email: map['email'] as String,
      gender: map['gender'] as String,
      skill: map['skill'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(username: $username, email: $email, gender: $gender, skill: $skill)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.username == username &&
        other.email == email &&
        other.gender == gender &&
        other.skill == skill;
  }

  @override
  int get hashCode {
    return username.hashCode ^
        email.hashCode ^
        gender.hashCode ^
        skill.hashCode;
  }
}
