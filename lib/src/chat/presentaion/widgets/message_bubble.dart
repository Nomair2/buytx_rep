import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final bool isSentByMe;
  final MessageEntity message;
  const MessageBubble({
    super.key,
    required this.isSentByMe,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: size.width * 0.6),
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: isSentByMe ? Theme.of(context).primaryColor : null,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 1.5,
                ),
              ),
              child:
                  isSentByMe
                      ? Text(
                        message.content!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                      : Text(
                        message.content!,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
            ),
            isSentByMe
                ? Container(
                  width: 100,
                  height: 25,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${message.sentAt!.hour}.${message.sentAt!.minute}',
                        style: TextStyle(color: Color(0xff8C8C8C)),
                      ),
                      BuildMessageStatus(message.status!),
                    ],
                  ),
                )
                : Container(
                  width: 60,
                  height: 25,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      '${message.sentAt!.hour}.${message.sentAt!.minute}',
                      style: TextStyle(color: Color(0xff8C8C8C)),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget BuildMessageStatus(String status) {
    IconData? icon;
    Color? color;

    switch (status) {
      case 'sending':
        icon = Icons.more_horiz;
        color = Colors.grey;
        break;
      case 'sent':
        icon = Icons.check;
        color = Colors.grey;
        break;
      case "delivered":
        icon = Icons.done_all;
        color = Colors.grey;
        break;
      case "read":
        icon = Icons.done_all;
        color = Colors.green;
        break;
    }

    return Icon(icon, size: 16, color: color);
  }
}
