import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  static String name = 'notification';
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            SizedBox(height: size.height * 0.1),
            Text(
              'الإشعارات',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _NotificationItem(
              userImage: 'assets/images/person.png',
              title: 'قام التاجر أغيد علوان بالرد على تعليقك',
              type: 'comment',
              comment: '" شكرًا لك!"',
              icon: Icons.account_circle,
              iconBg: Colors.green,
              isFirst: true,
            ),
            // const SizedBox(height: 8),
            _NotificationItem(
              userImage: 'assets/images/person.png',
              title: 'قام فارس أحمد بتقييمك',
              comment: '"تجربة رائعة."',
              type: 'comment',
              icon: Icons.account_circle,
              iconBg: Colors.green,
              isFirst: true,
            ),
            // const SizedBox(height: 8),
            VerificationNotification(),
            // _NotificationItem(
            //   userImage: '',
            //   title: 'تم قبول طلبك التوثيق بنجاح',
            //   comment: '"تجربة رائعة."',
            //   type: 'verification',
            //   icon: Icons.account_circle,
            //   iconBg: Colors.green,
            //   isFirst: true,
            // ),
            // const SizedBox(height: 8),
            _NotificationItem(
              userImage: 'assets/images/person.png',
              title: 'قام فارس أحمد بتقييمك',
              comment: '"تجربة رائعة."',
              type: 'elevuation',
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String? userImage;
  final String title;
  final String? comment;
  final IconData? icon;
  final Color? iconBg;
  final bool isFirst;
  final String type;
  const _NotificationItem({
    Key? key,
    this.userImage,
    required this.title,
    required this.type,
    this.comment,
    this.icon,
    this.iconBg,
    this.isFirst = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor.withAlpha(100),
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(userImage ?? ''),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      type == 'elevuation'
                          ? Icons.thumb_up
                          : Icons.mark_unread_chat_alt,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
                if (comment != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    comment!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              Text(
                ' ٣ د',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              SizedBox(height: 2),
              Icon(Icons.more_horiz),
            ],
          ),
        ],
      ),
    );
  }
}

class VerificationNotification extends StatelessWidget {
  const VerificationNotification({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor.withAlpha(100),
          ),
        ),
      ),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Theme.of(context).primaryColor,
            child: Expanded(child: Icon(Icons.person, color: Colors.white)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.verified,
                      size: 16,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'تم قبول طلبك التوثيق بنجاح',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Text(
                ' ٣ د',
                style: TextStyle(color: Colors.grey[400], fontSize: 12),
              ),
              SizedBox(height: 2),
              Icon(Icons.more_horiz),
            ],
          ),
        ],
      ),
    );
  }
}
