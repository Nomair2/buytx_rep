import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:buytx/src/chat/domain/entity/user_chat_entity.dart';

class CustomChatCard extends StatelessWidget {
  const CustomChatCard({super.key, required this.chats});

  final UserChatEntity chats;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      height: 68,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${chats.lastMessageDate.hour}.${chats.lastMessageDate.minute}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 12,
                ),
              ),
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Center(child: Text('${chats.messageCount}')),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${chats.fullName}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${chats.lastMessage}',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 4),
              CircleAvatar(
                backgroundImage:
                //later we bring the image from the api
                AssetImage("assets/images/person.png"),
                maxRadius: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
