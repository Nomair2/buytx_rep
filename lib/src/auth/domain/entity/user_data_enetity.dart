// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'package:buytx/src/auth/data/model/user_data_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

class UserEntity {
  final bool? success;
  final String? msg;
  final String? token;
  final UserData? userData;

  UserEntity({this.success, this.msg, this.token, this.userData});
}

UserEntity formUserModel(UserModel userModel) => UserEntity(
  success: userModel.success,
  msg: userModel.msg,
  token: userModel.token,
  userData: formUserDataModel(userModel.userData!),
);

class UserData {
  final Rate? rate;
  final bool? phoneVisible;
  final String? id;
  final String? email;
  final String? username;
  final String? fullName;
  final String? phone;
  final List<String>? authProvider;
  final bool? activated;
  final String? verificationCode;
  final int? numberOfAlerts;
  final String? state;
  final String? verifiedStatus;
  final List<dynamic>? followers;
  final List<dynamic>? following;
  final String? role;
  final int? numberOfReports;
  final List<dynamic>? favourites;
  final List<dynamic>? blockedUsers;
  final DateTime? joinedDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? verificationCodeExpires;
  final String? lastLoginTime;
  final List<String>? fcmTokens;
  final List<dynamic>? sections;

  UserData({
    this.rate,
    this.phoneVisible,
    this.id,
    this.email,
    this.username,
    this.fullName,
    this.phone,
    this.authProvider,
    this.activated,
    this.verificationCode,
    this.numberOfAlerts,
    this.state,
    this.verifiedStatus,
    this.followers,
    this.following,
    this.role,
    this.numberOfReports,
    this.favourites,
    this.blockedUsers,
    this.joinedDate,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.verificationCodeExpires,
    this.lastLoginTime,
    this.fcmTokens,
    this.sections,
  });
}

UserData formUserDataModel(UserDataModel user) => UserData(
  rate: formRateModel(user.rate!),
  phoneVisible: user.phoneVisible,
  id: user.id,
  email: user.email,
  username: user.username,
  fullName: user.fullName,
  phone: user.phone,
  authProvider: user.authProvider,
  activated: user.activated,
  verificationCode: user.verificationCode,
  numberOfAlerts: user.numberOfAlerts,
  state: user.state,
  verifiedStatus: user.verifiedStatus,
  followers: user.followers,
  following: user.following,
  role: user.role,
  numberOfReports: user.numberOfReports,
  favourites: user.favourites,
  blockedUsers: user.blockedUsers,
  joinedDate: user.joinedDate,
  createdAt: user.createdAt,
  updatedAt: user.updatedAt,
  v: user.v,
  verificationCodeExpires: user.verificationCodeExpires,
  lastLoginTime: user.lastLoginTime,
  fcmTokens: user.fcmTokens,
  sections: user.sections,
);

class Rate {
  final int? stars;
  final int? number;

  Rate({this.stars, this.number});
}

Rate formRateModel(RateModel rate) =>
    Rate(stars: rate.stars, number: rate.number);
