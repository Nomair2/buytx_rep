import 'package:buytx/core/utils/typedefs.dart';

class UserRequestModel {
  int? id;
  String? email;
  String? password;
  String? username;
  String? fullName;
  String? number;
  List<String>? authProvider;

  UserRequestModel({
    this.email,
    this.password,
    this.username,
    this.id,
    this.fullName,
    this.number,
    this.authProvider,
  });

  DataMap toMap() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'username': username,
      'fullName': fullName,
      'number': number,
      'authProvider': authProvider?.toList(),
    };
  }

  factory UserRequestModel.fromMap(DataMap map) {
    return UserRequestModel(
      email: map['email'],
      password: map['password'],
      username: map['username'],
      id: map['id'],
      fullName: map['fullName'],
      number: map['number'],
      authProvider:
          map['authProvider'] != null
              ? List<String>.from(map['authProvider'])
              : null,
    );
  }

  static UserRequestModel empty() {
    return UserRequestModel();
  }

  UserRequestModel copyWith({
    String? email,
    String? password,
    String? username,
    String? fullName,
    int? id,
    String? number,
    List<String>? authProvider,
  }) {
    return UserRequestModel(
      email: email ?? this.email,
      id: id ?? this.id,
      password: password ?? this.password,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      number: number ?? this.number,
      authProvider: authProvider ?? this.authProvider,
    );
  }
}
