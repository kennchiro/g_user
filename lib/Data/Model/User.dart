// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? email_verified_at;
  final int? isActive;
  final int? isAdmin;
  final String? created_at;
  final String? update_at;
  final String? password;

  const User({
    this.id,
    this.name,
    this.email,
    this.email_verified_at,
    this.isActive,
    this.isAdmin,
    this.created_at,
    this.update_at,
    this.password,
  });

  @override
  List<Object> get props {
    return [
      id!,
      name!,
      email!,
      email_verified_at!,
      isActive!,
      isAdmin!,
      created_at!,
      update_at!,
      password!,
    ];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': email_verified_at,
      'isActive': isActive,
      'isAdmin': isAdmin,
      'created_at': created_at,
      'update_at': update_at,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      email_verified_at: map['email_verified_at'] != null ? map['email_verified_at'] as String : null,
      isActive: map['isActive'] != null ? map['isActive'] as int : null,
      isAdmin: map['isAdmin'] != null ? map['isAdmin'] as int : null,
      created_at: map['created_at'] != null ? map['created_at'] as String : null,
      update_at: map['update_at'] != null ? map['update_at'] as String : '',
      password: map['password'] != null ? map['password'] as String : null,
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? email_verified_at,
    int? isActive,
    int? isAdmin,
    String? created_at,
    String? update_at,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      email_verified_at: email_verified_at ?? this.email_verified_at,
      isActive: isActive ?? this.isActive,
      isAdmin: isAdmin ?? this.isAdmin,
      created_at: created_at ?? this.created_at,
      update_at: update_at ?? this.update_at,
      password: password ?? this.password,
    );
  }
}
