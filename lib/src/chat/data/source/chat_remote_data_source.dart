import 'dart:convert';
import 'package:buytx/src/chat/data/model/upload_chat_media_model.dart';
import 'package:buytx/src/chat/data/model/upload_message_model.dart';
import 'package:buytx/src/chat/domain/usecases/get_chats.dart';
import 'package:buytx/src/chat/domain/usecases/upload_message.dart';
import 'package:flutter/material.dart';
import 'package:buytx/core/error/exceptions.dart';
import 'package:buytx/core/utils/constant/network_constants.dart';
import 'package:buytx/core/utils/error_response.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/chat/data/model/message_model.dart';
import 'package:buytx/src/chat/data/model/user_chat_model.dart';
import 'package:http/http.dart' as http;
import 'package:buytx/src/chat/domain/usecases/get_messages.dart';

abstract class ChatRemoteDataSource {
  Future<List<UserChatModel>> getChats(ChatsPatams params);

  Future<List<MessageModel>> getMessages(MessageParms params);


  // Future<String> uploadChatMedia(UploadChatMediaModel params);
}

const Get_Chat_ENDPOINT = 'chats/MyChats';
const Get_message_ENDPOINT = 'chats/getMessages';
const getMessageUploadEndpoint = 'chat/uploadURL';

class ChatRemoteDataSourceImp extends ChatRemoteDataSource {
  ChatRemoteDataSourceImp(this._client);
  final http.Client _client;
  @override
  Future<List<UserChatModel>> getChats(ChatsPatams params) async {
    print("in bloc source data 1 ");
    try {
      final url = Uri.parse('${NetworkConstants.baseUrl}$Get_Chat_ENDPOINT');
      print("in bloc source data 2 ");
      final response = await _client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${params.token}',
          'Content-Type': 'application/json',
        },
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
      final dataReturn = jsonDecode(response.body) as List;
      final userChatModels =
          dataReturn.map((json) => UserChatModel.fromMap(json)).toList();
      print("in bloc source data 4 ");

      return userChatModels;
    } on ServerExceptions {
      rethrow;
    } catch (e, s) {
      print("in bloc source data 5 ");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerExceptions(message: 'please , try again ', statusCode: 500);
    }
  }

  @override
  Future<List<MessageModel>> getMessages(MessageParms params) async {
    print("in bloc source data 1 ");
    print(params.pagginationNum);
    print(params.id);
    try {
      final url = Uri.parse(
        '${NetworkConstants.baseUrl}$Get_message_ENDPOINT/${params.id}/${params.pagginationNum}',
      );
      print(url);
      print("in bloc source data 2 ");
      final response = await _client.get(
        url,
        headers: {
          'Authorization': 'Bearer ${params.token}',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode != 200) {
        print("in bloc source data 3 ");
        final payload = jsonDecode(response.body) as DataMap;
        final errorResponse = ErrorResponse.fromMap(payload);
        throw ServerExceptions(
          message: errorResponse.errorMessage,
          statusCode: response.statusCode,
        );
      }
      print(response.body);
      final dataReturn = jsonDecode(response.body) as List;
      print(dataReturn);
      print("1");
      final userChatModels = parseMessages(dataReturn);
      print("in bloc source data 4 ");
      return userChatModels;
    } on ServerExceptions {
      rethrow;
    } catch (e, s) {
      print("in bloc source data 5 ");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      throw ServerExceptions(message: 'please , try again ', statusCode: 500);
    }
  }


}
