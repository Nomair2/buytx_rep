// To parse this JSON data, do
//
//     final user = userFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

UserModel userFromMap(String str) => UserModel.fromMap(json.decode(str));

// String userToMap(UserModel data) => json.encode(data.toMap());

class UserModel {
  final bool? success;
  final String? msg;
  final String? token;
  final UserDataModel userData;

  UserModel({this.success, this.msg, this.token, required this.userData});

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
    success: json["success"],
    msg: json["msg"],
    token: json["token"],
    userData: UserDataModel.fromMap(json["userData"]),
  );

  // Map<String, dynamic> toMap() => {
  //   "success": success,
  //   "msg": msg,
  //   "token": token,
  //   "userData": userData!.toMap(),
  // };
}

class UserDataModel {
  final RateModel? rate;
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

  UserDataModel({
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

  factory UserDataModel.fromMap(Map<String, dynamic> json) => UserDataModel(
    rate: RateModel.fromMap(json["rate"]),
    phoneVisible: json["phoneVisible"],
    id: json["_id"],
    email: json["email"],
    username: json["username"],
    fullName: json["fullName"],
    phone: json["phone"],
    authProvider: List<String>.from(json["authProvider"].map((x) => x)),
    activated: json["activated"],
    verificationCode: json["verificationCode"],
    numberOfAlerts: json["numberOfAlerts"],
    state: json["state"],
    verifiedStatus: json["verifiedStatus"],
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    following: List<dynamic>.from(json["following"].map((x) => x)),
    role: json["role"],
    numberOfReports: json["numberOfReports"],
    favourites: List<dynamic>.from(json["favourites"].map((x) => x)),
    blockedUsers: List<dynamic>.from(json["blockedUsers"].map((x) => x)),
    joinedDate: DateTime.parse(json["joinedDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    verificationCodeExpires: DateTime.parse(json["verificationCodeExpires"]),
    lastLoginTime: json["lastLoginTime"],
    fcmTokens: List<String>.from(json["fcmTokens"].map((x) => x)),
    sections: List<dynamic>.from(json["sections"].map((x) => x)),
  );

  // Map<String, dynamic> toMap() => {
  //   "rate": rate.toMap(),
  //   "phoneVisible": phoneVisible,
  //   "_id": id,
  //   "email": email,
  //   "username": username,
  //   "fullName": fullName,
  //   "phone": phone,
  //   "authProvider": List<dynamic>.from(authProvider!.map((x) => x)),
  //   "activated": activated,
  //   "verificationCode": verificationCode,
  //   "numberOfAlerts": numberOfAlerts,
  //   "state": state,
  //   "verifiedStatus": verifiedStatus,
  //   "followers": List<dynamic>.from(followers!.map((x) => x)),
  //   "following": List<dynamic>.from(following!.map((x) => x)),
  //   "role": role,
  //   "numberOfReports": numberOfReports,
  //   "favourites": List<dynamic>.from(favourites!.map((x) => x)),
  //   "blockedUsers": List<dynamic>.from(blockedUsers!.map((x) => x)),
  //   "joinedDate": joinedDate!.toIso8601String(),
  //   "createdAt": createdAt!.toIso8601String(),
  //   "updatedAt": updatedAt!.toIso8601String(),
  //   "__v": v,
  //   "verificationCodeExpires": verificationCodeExpires!.toIso8601String(),
  //   "lastLoginTime": lastLoginTime,
  //   "fcmTokens": List<dynamic>.from(fcmTokens!.map((x) => x)),
  //   "sections": List<dynamic>.from(sections!.map((x) => x)),
  // };
}

class RateModel {
  final int? stars;
  final int? number;

  RateModel({this.stars, this.number});

  factory RateModel.fromMap(Map<String, dynamic> json) =>
      RateModel(stars: json["stars"], number: json["number"]);

  // Map<String, dynamic> toMap() => {"stars": stars, "number": number};
}

// To parse this JSON data, do
//
//     final userChatEntity = userChatEntityFromMap(jsonString);

// UserModel userChatEntityFromMap(String str) =>
//     UserModel.fromMap(json.decode(str));

// String userChatEntityToMap(UserModel data) => json.encode(data.toMap());

// class UserModel {
//   final bool success;
//   final String msg;
//   final String token;
//   final UserDataModel userData;

//   UserModel({
//     required this.success,
//     required this.msg,
//     required this.token,
//     required this.userData,
//   });

//   factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
//         success: json["success"],
//         msg: json["msg"],
//         token: json["token"],
//         userData: UserDataModel.fromMap(json["userData"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "success": success,
//         "msg": msg,
//         "token": token,
//         "userData": userData.toMap(),
//       };
// }

// class UserDataModel {
//   final RateModel rate;
//   final String id;
//   final String email;
//   final String username;
//   final List<dynamic> fcmTokens;
//   final String fullName;
//   final String phone;
//   final bool phoneVisible;
//   final List<String> authProvider;
//   final bool activated;
//   final int numberOfAlerts;
//   final String state;
//   final String verifiedStatus;
//   final String role;
//   final int numberOfReports;
//   final List<dynamic> favourites;
//   final List<dynamic> blockedUsers;
//   final DateTime joinedDate;
//   final List<dynamic> sections;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int v;

//   UserDataModel({
//     required this.rate,
//     required this.id,
//     required this.email,
//     required this.username,
//     required this.fcmTokens,
//     required this.fullName,
//     required this.phone,
//     required this.phoneVisible,
//     required this.authProvider,
//     required this.activated,
//     required this.numberOfAlerts,
//     required this.state,
//     required this.verifiedStatus,
//     required this.role,
//     required this.numberOfReports,
//     required this.favourites,
//     required this.blockedUsers,
//     required this.joinedDate,
//     required this.sections,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.v,
//   });

//   factory UserDataModel.fromMap(Map<String, dynamic> json) => UserDataModel(
//         rate: RateModel.fromMap(json["rate"]),
//         id: json["_id"],
//         email: json["email"],
//         username: json["username"],
//         fcmTokens: List<dynamic>.from(json["fcmTokens"].map((x) => x)),
//         fullName: json["fullName"],
//         phone: json["phone"],
//         phoneVisible: json["phoneVisible"],
//         authProvider: List<String>.from(json["authProvider"].map((x) => x)),
//         activated: json["activated"],
//         numberOfAlerts: json["numberOfAlerts"],
//         state: json["state"],
//         verifiedStatus: json["verifiedStatus"],
//         role: json["role"],
//         numberOfReports: json["numberOfReports"],
//         favourites: List<dynamic>.from(json["favourites"].map((x) => x)),
//         blockedUsers: List<dynamic>.from(json["blockedUsers"].map((x) => x)),
//         joinedDate: DateTime.parse(json["joinedDate"]),
//         sections: List<dynamic>.from(json["sections"].map((x) => x)),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toMap() => {
//         "rate": rate.toMap(),
//         "_id": id,
//         "email": email,
//         "username": username,
//         "fcmTokens": List<dynamic>.from(fcmTokens.map((x) => x)),
//         "fullName": fullName,
//         "phone": phone,
//         "phoneVisible": phoneVisible,
//         "authProvider": List<dynamic>.from(authProvider.map((x) => x)),
//         "activated": activated,
//         "numberOfAlerts": numberOfAlerts,
//         "state": state,
//         "verifiedStatus": verifiedStatus,
//         "role": role,
//         "numberOfReports": numberOfReports,
//         "favourites": List<dynamic>.from(favourites.map((x) => x)),
//         "blockedUsers": List<dynamic>.from(blockedUsers.map((x) => x)),
//         "joinedDate": joinedDate.toIso8601String(),
//         "sections": List<dynamic>.from(sections.map((x) => x)),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }

// class RateModel {
//   final int stars;
//   final int number;

//   RateModel({
//     required this.stars,
//     required this.number,
//   });

//   factory RateModel.fromMap(Map<String, dynamic> json) => RateModel(
//         stars: json["stars"],
//         number: json["number"],
//       );

//   Map<String, dynamic> toMap() => {
//         "stars": stars,
//         "number": number,
//       };
// }
