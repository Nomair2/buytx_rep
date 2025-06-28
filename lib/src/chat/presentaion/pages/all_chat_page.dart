import 'package:buytx/core/services/route/router.dart';
import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_states.dart';
import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';
import 'package:buytx/src/chat/presentaion/pages/messages_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:buytx/src/chat/presentaion/widgets/custom_chat_card.dart';
import 'package:buytx/src/chat/presentaion/widgets/custom_chat_shimmer.dart';
import 'package:buytx/src/chat/presentaion/widgets/custom_search_chat.dart';
import 'package:go_router/go_router.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

class AllChatPage extends StatefulWidget {
  static String name = 'chats';

  AllChatPage({super.key});

  @override
  State<AllChatPage> createState() => _AllChatPageState();
}

class _AllChatPageState extends State<AllChatPage> {
  int pagginationNum = 0;

  @override
  void initState() {
    context.read<messagesBloc>().add(FetchChatsEvent(pagginationNum: "0"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            const CustomSearchChat(),
            SizedBox(height: size.height * 0.04),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'المحادثات',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  width: 66,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                  ),
                ),
                BlocBuilder<messagesBloc, MessagesStates>(
                  builder: (context, state) {
                    if (state is MessagesLoading) {
                      return CustomChatShimmer();
                    } else {
                      final chats = context.read<messagesBloc>().chats;
                      return SizedBox(
                        height: size.height * 0.72,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            // pagginationNum++;
                            // context.read<messagesBloc>().add(
                            //   FetchChatsEvent(
                            //     pagginationNum: pagginationNum.toString(),
                            //   ),
                            // );
                          },
                          child: ListView.builder(
                            itemCount: chats.length,
                            itemBuilder:
                                (context, index) => GestureDetector(
                                  onTap: () {
                                    context.read<messagesBloc>().add(
                                      FetchMesssagesEvent(
                                        id: chats[index].id,
                                        pagginationNum: "0",
                                      ),
                                    );
                                    context.pushNamed(
                                      MessagesScreen.name,
                                      extra: MessagesParameterPage(
                                        bloc: context.read<messagesBloc>(),
                                        user: chats[index],
                                      ),
                                    );
                                  },
                                  child: CustomChatCard(chats: chats[index]),
                                ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
