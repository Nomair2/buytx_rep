import 'package:buytx/src/chat/data/model/upload_chat_media_model.dart';
import 'package:buytx/src/chat/data/model/upload_message_model.dart';
import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';
import 'package:buytx/src/chat/domain/usecases/get_chats.dart';
import 'package:buytx/src/chat/domain/usecases/upload_message.dart';
import 'package:dartz/dartz.dart';
import 'package:buytx/core/error/exceptions.dart';
import 'package:buytx/core/error/failure.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/chat/data/model/message_model.dart';
import 'package:buytx/src/chat/data/model/user_chat_model.dart';
import 'package:buytx/src/chat/data/source/chat_remote_data_source.dart';
import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:buytx/src/chat/domain/repository/chat_repository.dart';
import 'package:buytx/src/chat/domain/usecases/get_messages.dart';

class ChatRepositoryImp extends ChatRepository {
  ChatRepositoryImp(this._chatRemoteDataSource);

  final ChatRemoteDataSource _chatRemoteDataSource;

  @override
  ResultFuture<List<UserChatEntity>> getChats(ChatsPatams params) async {
    print("in bloc repository data 1 ");
    try {
      final List<UserChatModel> dataReturn = await _chatRemoteDataSource
          .getChats(params);
      List<UserChatEntity> data = convertToList(dataReturn);
      print("in bloc repository data 2 ");
      return Right(data);
    } on ServerExceptions catch (e) {
      print("in bloc repository data 3 ");
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<MessageEntity>> getMessages(MessageParms parms) async {
    print("in bloc repository data 1 ");
    try {
      final List<MessageModel> dataReturn = await _chatRemoteDataSource
          .getMessages(parms);
      List<MessageEntity> data = fromMessageModel(dataReturn);
      print("in bloc repository data 2 ");
      return Right(data);
    } on ServerExceptions catch (e) {
      print("in bloc repository data 3 ");
      return Left(ServerFailure.fromException(e));
    }
  }


  // @override
  // ResultFuture<String> UploadChatMedia(UploadChatMediaEntity params) async{
  //   print("in bloc repository data 1 ");
  //   try {
  //     final model = UploadChatMediaModel.fromEntity(params);
  //     final String dataReturn = await _chatRemoteDataSource
  //         .uploadChatMedia(model);
  //     print("in bloc repository data 2 ");
  //     return Right(dataReturn);
  //   } on ServerExceptions catch (e) {
  //     print("in bloc repository data 3 ");
  //     return Left(ServerFailure.fromException(e));
  //   }
  // }
}
