import 'package:flutter/material.dart';
import 'package:voice_message_package/voice_message_package.dart';

class AudioMessageBubble extends StatefulWidget {
  final String audioUrl; // Can be a local path or network URL
  final bool isMe;

  const AudioMessageBubble({
    Key? key,
    required this.audioUrl,
    required this.isMe,
  }) : super(key: key);

  @override
  _AudioMessageBubbleState createState() => _AudioMessageBubbleState();
}

class _AudioMessageBubbleState extends State<AudioMessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      margin: const EdgeInsets.all(10),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.7,
      ),
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          VoiceMessageView(
            controller: VoiceController(
              audioSrc: widget.audioUrl,
              maxDuration: const Duration(seconds: 10),
              isFile: false,
              onComplete: () {
                /// do something on complete
              },
              onPause: () {
                /// do something on pause
              },
              onPlaying: () {
                /// do something on playing
              },
              onError: (err) {
                /// do somethin on error
              },
            ),
            innerPadding: 12,
            cornerRadius: 20,
          ),
        ],
      ),
    );
  }
}
