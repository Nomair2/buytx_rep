import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';
import 'package:buytx/src/chat/presentaion/pages/appbar_message.dart';
import 'package:buytx/src/chat/presentaion/widgets/file_bubble.dart';
import 'package:buytx/src/chat/presentaion/widgets/image_bubble.dart';
import 'package:buytx/src/chat/presentaion/widgets/message_bubble.dart';
import 'package:buytx/src/chat/presentaion/widgets/record_bubble.dart';
import 'package:buytx/src/chat/presentaion/widgets/sending_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_states.dart';
import 'package:image_picker/image_picker.dart';

class MessagesScreen extends StatefulWidget {
  static String name = 'messageScreen';
  UserChatEntity? userChatEntity;
  MessagesScreen({super.key, required this.userChatEntity});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  TextEditingController sendField = TextEditingController();

  ScrollController controller = ScrollController();
  ImagePicker _pickerImage = ImagePicker();
  int pagginationNum = 0;

  @override
  void initState() {
    context.read<messagesBloc>()..add(
      FetchMesssagesEvent(id: widget.userChatEntity!.id, pagginationNum: '0'),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<messagesBloc, MessagesStates>(
      builder: (context, state) {
        return PopScope(
          canPop: true,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              context.read<messagesBloc>().opening = false;
            }
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.onSurface,
              body: Column(
                children: [
                  AppBarMessages(size: size, widget: widget),
                  Expanded(
                    child: Container(
                      // color: Theme.of(context).colorScheme.onSurface,
                      child: BlocBuilder<messagesBloc, MessagesStates>(
                        builder: (context, state) {
                          if (state is MessagesLoading) {
                            return Center(child: CircularProgressIndicator());
                          } else if (state is MessagesLoaded) {
                            final messages = state.messages.reversed.toList();
                            return RefreshIndicator(
                              color: Theme.of(context).primaryColor,
                              onRefresh: () async {
                                pagginationNum++;
                                print("123");
                                context.read<messagesBloc>().add(
                                  FetchMesssagesEvent(
                                    id: widget.userChatEntity!.id,
                                    pagginationNum: pagginationNum.toString(),
                                  ),
                                );
                              },
                              child: ListView(
                                reverse: true,
                                children: List.generate(messages.length, (
                                  index,
                                ) {
                                  bool SentByMe =
                                      messages[index].sender ==
                                              widget.userChatEntity!.id
                                          ? false
                                          : true;
                                  print("-----------------");
                                  print("-----------------");
                                  if (messages[index].media != null) {
                                    if (messages[index].media!.type ==
                                        'image') {
                                      return ImageBubble(
                                        SentByMe: SentByMe,
                                        message: messages[index],
                                      );
                                    }
                                    if (messages[index].media!.type ==
                                        'document') {
                                      print(" open document ");
                                      String fileName =
                                          messages[index].media!.url
                                              .split('/')
                                              .last
                                              .split('?')
                                              .first;
                                      return FileBubble(
                                        fileName: fileName,
                                        isSentByMe: SentByMe,
                                        url: messages[index].media!.url,
                                      );
                                    }
                                    if (messages[index].media!.type ==
                                        "audio") {
                                      print(" play audio ");
                                      return AudioMessageBubble(
                                        audioUrl: messages[index].media!.url,
                                        isMe: SentByMe,
                                      );
                                    }
                                  }
                                  return MessageBubble(
                                    isSentByMe: SentByMe,
                                    message: messages[index],
                                  );
                                }),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                  ),
                  SendingField(
                    sendField: sendField,
                    widget: widget,
                    pickerImage: _pickerImage,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
