import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
import 'package:buytx/src/chat/presentaion/pages/messages_page.dart';
import 'package:buytx/src/home/widgets/customCircularButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppBarMessages extends StatelessWidget {
  const AppBarMessages({super.key, required this.size, required this.widget});

  final Size size;
  final MessagesScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 90),
      // margin: EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.only(top: 10),
      // height: size.height * 0.14,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            offset: const Offset(0, 1),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<messagesBloc>().opening = false;
                  context.pop();
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                backgroundImage:
                //later we bring the image from the api
                AssetImage("assets/images/person.png"),
                backgroundColor: Theme.of(context).primaryColor,
                // backgroundImage: NetworkImage(widget.userChatEntity!.),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width * 0.5,
                    child: Text(
                      widget.userChatEntity!.fullName,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(height: 4),
                  Text(
                    widget.userChatEntity!.lastLoginTime!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  // BlocBuilder<messagesBloc, MessagesStates>(
                  //   builder: (context, state) {
                  //     if (state is LastSeenState) {
                  //       if (state.partnerId ==
                  //           widget.userChatEntity!.id) {
                  //         return Text(
                  //           state.lastSeen,
                  //           style: TextStyle(
                  //             fontSize: 12,
                  //             color: Theme.of(context).primaryColor,
                  //           ),
                  //         );
                  //       }
                  //     }
                  //     return Text(
                  //       widget.userChatEntity!.lastLoginTime!,
                  //       style: TextStyle(
                  //         fontSize: 12,
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
          // const SizedBox(width: 40),
          Container(
            height: 44,
            margin: const EdgeInsets.only(right: 20),
            width: 44,
            child: Builder(
              builder: (context) {
                return PopupMenuButton(
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'view_contact',
                          child: Text('View contact'),
                        ),
                        const PopupMenuItem(
                          value: 'search',
                          child: Text('Search'),
                        ),
                        const PopupMenuItem(
                          value: 'mute',
                          child: Text('Mute notifications'),
                        ),
                        const PopupMenuItem(
                          value: 'clear',
                          child: Text('Clear chat'),
                        ),
                      ],
                  onSelected: (value) {
                    // TODO: Handle menu actions
                  },
                );
                // return CustomSmallButton(
                //   colorIcon: Colors.black,
                //   colors: Colors.white,
                //   radius: 12,
                //   icons: Icons.more_vert,
                //   onPressed: () {
                //     // context.read<messagesBloc>().add(
                //     //   ReadMessageEvent(),
                //     // );
                //     // BlocProvider.of<messagesBloc>(
                //     //   context,
                //     // ).add(ReadMessageEvent());
                //   },
                //   size: 30,
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
