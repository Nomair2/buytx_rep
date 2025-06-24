import 'package:buytx/core/usercase/usecase.dart';
import 'package:buytx/core/utils/typedefs.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:buytx/src/chat/domain/repository/chat_repository.dart';

class GetChatsUseCase extends UseCase<List<UserChatEntity>, ChatsPatams> {
  GetChatsUseCase(this._chatRepository);
  final ChatRepository _chatRepository;
  @override
  ResultFuture<List<UserChatEntity>> call(ChatsPatams params) {
    return _chatRepository.getChats(params);
  }
}

class ChatsPatams {
  final String pagginationNum;
  final String token;
  ChatsPatams(this.token, this.pagginationNum);
}
