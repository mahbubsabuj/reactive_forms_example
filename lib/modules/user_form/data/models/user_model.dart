import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? avater;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String gender;
  final String country;
  const UserModel({
    this.id,
    this.avater,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender,
    required this.country,
  });

  UserModel copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? gender,
    String? country,
  }) {
    return UserModel(
      id: id ?? this.id,
      avater: avater ?? avater,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      gender: gender ?? this.gender,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'gender': gender,
      'country': country,
      'avater': avater,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      avater: map['avater'],
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      email: map['email'] as String,
      password: '123456',
      gender: 'Male',
      country: 'Bangladesh',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  List<Object?> get props =>
      [id, firstName, lastName, email, password, gender, country];
}
