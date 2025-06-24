import 'package:buytx/src/chat/domain/entity/message_entity.dart';
import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({super.key, required this.SentByMe, required this.message});

  final bool SentByMe;
  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            SentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Align(
            alignment: SentByMe ? Alignment.centerRight : Alignment.centerLeft,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                message.media!.url,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SentByMe
              ? Container(
                width: 100,
                height: 25,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
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
