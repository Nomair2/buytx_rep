import 'dart:io';

import 'package:buytx/src/chat/domain/entity/upload_message_entity.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:buytx/src/chat/domain/usecases/get_chats.dart';
import 'package:buytx/src/chat/domain/usecases/upload_message.dart';
import 'package:dartz/dartz.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/core/common/singletons/cache_helper.dart';
import 'package:buytx/core/error/failure.dart';
import 'package:buytx/core/services/injection_container.dart';
import 'package:buytx/core/services/socket_service.dart';
import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:buytx/src/chat/domain/usecases/get_messages.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_states.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';

class messagesBloc extends Bloc<MesssagesEvents, MessagesStates> {
  List<MessageEntity> messages = [];
  List<UserChatEntity> chats = [];
  //TODO: Move to data layer.
  IO.Socket? socket; //Never use late.
  bool _isDisposed = false;
  bool opening = false;

  messagesBloc() : super(MessagesLoading()) {
    on<MessagesLoadingEvent>(_init);
    on<FetchMesssagesEvent>(_fetchmessagess);
    on<SendMessageEvent>(_sendMessage);
    on<ReceiveMessageEvent>(_receiveMessage);
    on<ReadMessageEvent>(_readMessage);
    on<ChangeStatusEvent>(_changeStatusEvent);
    on<FetchChatsEvent>(_fetchChats);
    on<CloseEvent>(_closeEvent);
    // on<LastSeenEvent>(_lastSeenEvent);
  }

  _init(event, emit) {
    print("------------------connecting ---------------------");
    String? token = sl<CacheHelper>().getSessionToken();

    socket = IO.io(
      "https://professional-audrye-mohammedalakkhras-c3be0efd.koyeb.app",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .enableForceNew()
          .setAuth({'token': token})
          .build(),
    );
    if (socket == null) {
      emit(MessagesError("Couldn't initiate a connection"));
    }
    socket!.connect();

    socket!.onConnect((_) {
      print('Socket connect : ${socket!.id}');
    });

    socket!.onDisconnect((_) {
      print('Socket disconnect ');
    });

    socket!.emit('signin', token);

    print("-----listen for all event you want  ----- ");
    socket!.on('LoadNewMessage', (data) {
      print("from LoadNewMessage is : ${data}");
      add(ReceiveMessageEvent(message: data));
    });

    socket!.on('receive', (data) {
      print("from receive is : ${data}");
      add(ReceiveMessageEvent(message: data));
    });

    socket!.on('lastSeenUpdate', (data) {
      print("-------------------from lastSeenUpdate event ---------------");
      print(data);
      add(
        LastSeenEvent(lastSeen: data['lastSeen'], partnerId: data['partnerId']),
      );
    });

    socket!.on('changeMessageStatus', (data) {
      print(
        "-------------------from changeMessageStatus event ---------------",
      );
      print(data);
      add(ChangeStatusEvent(id: data['id'], status: data['status']));
    });
  }

  _closeEvent(CloseEvent event, emit) {
    if (socket != null) {
      socket!.disconnect();
    }
  }

  @override
  Future<void> close() {
    _isDisposed = true;
    opening = false;
    // _cket.off('LoadNewMessage');
    _removeSocketListeners();
    return super.close();
  }

  void _removeSocketListeners() {
    if (socket != null) {
      socket!.off('LoadNewMessage');
      socket!.off('changeMessageStatus');
      socket!.off('lastSeenUpdate');
      socket!.off('receive');
    }

    // socket.disconnect();

    // _cket.off('error');
  }

  _lastSeenEvent(LastSeenEvent event, emit) {
    emit(LastSeenState(lastSeen: event.lastSeen, partnerId: event.partnerId));
    emit(MessagesLoaded(List.from(messages)));
  }

  _readMessage(ReadMessageEvent event, emit) {
    String? id = sl<CacheHelper>().getUserId();
    print("from _readMessage event");
    print("my id is ${id}");
    for (var i in messages) {
      print(i.status);
      print(i.content);
      print(i.receiver);
      if (i.status != 'read' && i.receiver == id) {
        print("from loop is ${i.status}");
        socket!.emit('messageRead', {'_id': i.id});
      }
    }
  }

  _changeStatusEvent(ChangeStatusEvent event, emit) {
    print('----------- from ChangeStatusEvent --------------');
    print(event.status);
    print(event.status);
    int index = messages.indexWhere((element) => element.id == event.id);
    print("the index is ${index}");
    messages[index].status = event.status;
    emit(MessagesLoaded(List.from(messages)));
  }

  _receiveMessage(ReceiveMessageEvent event, emit) async {
    if (_isDisposed) return;

    print("Received new message: ${event.message}");
    print("messages.length 4 ${messages.length}");
    try {
      final message = MessageEntity(
        content: event.message['content'],
        id: event.message['_id'],
        sender: event.message['sender']['_id'],
        status: event.message['status'],
        receiver: event.message['received'],
        sentAt: DateTime.parse(event.message["sentAt"]),
      );
      print("the opening is ${opening}");
      print("the event.message['_id'] is ${event.message['_id']}");
      // opening == true
      //     ?
      // SocketService().socket.emit('readMessage', {'_id': event.message['_id']});
      // : SocketService().socket.emit('deliveredMessage', {
      //   '_id': event.message['_id'],
      // });
      print(messages.length);
      // print(messages[messages.length - 1].content);
      messages.add(message);
      print(messages.length);
      // print(messages[messages.length - 1].content);
      emit(MessagesLoaded(List.from(messages)));
    } catch (e) {
      print("Error processing received message: $e");
    }
  }

  _sendMessage(SendMessageEvent event, emit) async {
    if (_isDisposed || event.message.trim().isEmpty) return;

    print("messages.length 3 ${messages.length}");
    print("Sending message to: ${event.idReceiver}");
    final newMessage = {'content': event.message, 'receiver': event.idReceiver};

    try {
      print("1");
      socket!.emit('sendMessage', newMessage);
    } catch (e) {
      print("Error sending message: $e");
    }
  }

  _fetchmessagess(event, emit) async {
    print("messages.length 1 ${messages.length}");
    if (_isDisposed || !(event is FetchMesssagesEvent)) return;

    String? token = sl<CacheHelper>().getSessionToken();
    try {
      Either<Failure, List<MessageEntity>> dataReturn =
          await sl<GetMessagesUseCase>().call(
            MessageParms(event.id, token!, event.pagginationNum),
          );

      dataReturn.fold((failure) => emit(MessagesError(failure.errorMessage)), (
        messagesList,
      ) {
        if (!_isDisposed) {
          opening = true;
          event.pagginationNum == '0'
              ? messages = messagesList
              : messages = [...messagesList, ...messages];
          print("messages.length 2 ${messages.length}");
          emit(MessagesLoaded(List.from(messages)));
          print("the Token is ${token}");

          // add(ReadMessageEvent());
          // _setupSocketListeners(token);
        }
      });
    } catch (e) {
      print("Error in fetch messages: $e");
      if (!_isDisposed) {
        emit(MessagesError("Failed to load messages"));
      }
    }
  }

  _fetchChats(FetchChatsEvent event, Emitter emit) async {
    print("in bloc code 1 ");
    event.pagginationNum == 0.toString() ? emit(MessagesLoading()) : null;
    // add(MessagesLoadingEvent());
    String? token = sl<CacheHelper>().getSessionToken();
    print("in bloc code 2 ");
    Either<Failure, List<UserChatEntity>> dataReturn =
        await sl<GetChatsUseCase>().call(
          ChatsPatams(token!, event.pagginationNum),
        );
    dataReturn.fold(
      (Failure failuer) {
        print("in bloc code 3 ");
        emit(MessagesError(failuer.errorMessage));
      },
      (r) {
        print("in bloc code 4 ");
        event.pagginationNum == '0' ? chats = r : chats = [...chats, ...r];
        event.pagginationNum == 0.toString() ? emit(ChatsLoaded(chats)) : null;
      },
    );
    print("in bloc code is not current event ");
  }
}
