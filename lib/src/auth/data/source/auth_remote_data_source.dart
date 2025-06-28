// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buytx/core/error/exceptions.dart';
import 'package:buytx/core/utils/constant/network_constants.dart';
import 'package:buytx/core/utils/error_response.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/auth/data/model/user_data_model.dart';
import 'package:buytx/src/auth/domain/entity/userRequest.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future signup(UserRequestEnity user);

  Future login(String email, String password);

  Future verifyOtp(String email, String otp);

  Future verifyAccount(String email);
}

const SIGNUP_ENDPOINT = 'users/signup';
const LOGIN_ENDPOINT = 'users/signin';
const VERVIFY_ACCOUNT__ENDPOINT = 'users/verifyEmail';
const VERVIFY_OTP_ENDPOINT = 'users/verify';

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  AuthRemoteDataSourceImp(this._client);
  final http.Client _client;

  @override
  Future<UserModel> login(String email, String password) async {
    print("in bloc source data 1 ");
    try {
      final url = Uri.parse('${NetworkConstants.baseUrl}$LOGIN_ENDPOINT');

      final response = await _client.post(
        url,
        body: jsonEncode({'identifier': email, 'password': password}),
        headers: NetworkConstants.header,
      );

      final payload = jsonDecode(response.body);

      if (response.statusCode != 200) {
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerExceptions(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      print(payload);
      UserModel user = UserModel.fromMap(payload);
      print("ddddddddddddddddddddddd");
      print(user.userData!.id);
      print(user.userData!.id);
      print(user.userData!.id);

      return user;

      // await sl<CacheHelper>().cacheSessionToken(payload['accessToken']);
      // final user = UserModel.fromMap(payload);
      // await sl<CacheHelper>().cacheUserId(user.id.toString());
    } on ServerExceptions {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerExceptions(message: 'please , try again ', statusCode: 500);
    }
  }

  @override
  Future<void> signup(UserRequestEnity user) async {
    print("in bloc source data 1 ");
    print(user.email);
    print(user.password);
    print(user.authProvider);
    print(user.username);
    print(user.fullName);
    print(user.phone);
    try {
      final url = Uri.parse('${NetworkConstants.baseUrl}$SIGNUP_ENDPOINT');
      final response = await _client.post(
        url,
        body: jsonEncode({
          'email': user.email,
          'password': user.password,
          'authProvider': user.authProvider,
          'username': user.username,
          'fullName': user.fullName,
          'phone': user.phone,
        }),
        headers: NetworkConstants.header,
      );
      print("in bloc source data 2 ");
      if (response.statusCode != 200) {
        print("in bloc source data 3 ");
        final payload = jsonDecode(response.body) as DataMap;
        print(response.body);
        final errorResponse = ErrorResponse.fromMap(payload);
        print(errorResponse.errorMessage);
        throw ServerExceptions(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      final url2 = Uri.parse(
        '${NetworkConstants.baseUrl}$VERVIFY_ACCOUNT__ENDPOINT',
      );
      final response2 = await _client.post(
        url2,
        body: jsonEncode({'email': user.email}),
        headers: NetworkConstants.header,
      );
      if (response.statusCode != 200) {
        final payload2 = jsonDecode(response2.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload2);
        throw ServerExceptions(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerExceptions {
      rethrow;
    } catch (e, s) {
      print("in bloc source data 4 ");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerExceptions(message: 'please , try again ', statusCode: 500);
    }
  }

  @override
  Future<void> verifyAccount(String email) async {
    try {
      final url = Uri.parse(
        '${NetworkConstants.baseUrl}$VERVIFY_ACCOUNT__ENDPOINT',
      );
      final response = await _client.post(
        url,
        body: jsonEncode({'email': email}),
        headers: NetworkConstants.header,
      );
      if (response.statusCode != 200) {
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerExceptions(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
    } on ServerExceptions {
      rethrow;
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerExceptions(message: 'please , try again ', statusCode: 500);
    }
  }

  @override
  Future<void> verifyOtp(String email, String otp) async {
    print("in bloc source data 1 ");
    try {
      final url = Uri.parse(
        '${NetworkConstants.baseUrl}$VERVIFY_OTP_ENDPOINT/${otp}',
      );
      print("in bloc source data 2 ");
      final response = await _client.post(
        url,
        body: jsonEncode({'email': email}),
        headers: NetworkConstants.header,
      );
      print(response.body);
      if (response.statusCode != 200) {
        print("in bloc source data 3 ");
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerExceptions(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      print("in bloc source data 4 ");
    } on ServerExceptions {
      rethrow;
    } catch (e, s) {
      print("in bloc source data 5 ");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerExceptions(message: 'please , try again ', statusCode: 500);
    }
  }

  //Until server side implements it.
  // Future<int> authWithGoogle() async {
  //   final GoogleSignIn signIn = GoogleSignIn.instance;
  // }
}

// final response = await _client.get(
//   uri , 
//   headers:Cache.instance.sessionToken!.toAuthHeader 
// )