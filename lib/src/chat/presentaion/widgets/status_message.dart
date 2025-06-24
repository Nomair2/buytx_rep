import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class Message {
  final String id;
  final String content;
  final String senderId;
  final bool isMe;
  String status; // 'sent', 'delivered', 'read'

  Message({
    required this.id,
    required this.content,
    required this.senderId,
    required this.isMe,
    this.status = 'sent',
  });
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];
  final String myId = "user123";

  @override
  void initState() {
    super.initState();
    _initSocket();
  }

  void _initSocket() {
    socket = IO.io('http://localhost:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.connect();

    socket.onConnect((_) {
      print('Connected to server');
      socket.emit("join", myId);
    });

    socket.on("message", (data) {
      final msg = Message(
        id: data["id"],
        content: data["content"],
        senderId: data["senderId"],
        isMe: data["senderId"] == myId,
        status: data["status"] ?? 'delivered',
      );

      setState(() {
        _messages.add(msg);
      });

      // Automatically emit "read" status if opened
      Future.delayed(Duration(milliseconds: 500), () {
        socket.emit("read", {"id": msg.id});
        _updateMessageStatus(msg.id, 'read');
      });
    });

    socket.on("statusUpdate", (data) {
      _updateMessageStatus(data["id"], data["status"]);
    });
  }

  void _sendMessage() {
    final content = _controller.text.trim();
    if (content.isEmpty) return;

    final msgId = DateTime.now().millisecondsSinceEpoch.toString();

    final message = Message(
      id: msgId,
      content: content,
      senderId: myId,
      isMe: true,
    );

    setState(() {
      _messages.add(message);
    });

    socket.emit("message", {"id": msgId, "content": content, "senderId": myId});

    _controller.clear();
  }

  void _updateMessageStatus(String id, String status) {
    final index = _messages.indexWhere((m) => m.id == id);
    if (index != -1) {
      setState(() {
        _messages[index].status = status;
      });
    }
  }

  @override
  void dispose() {
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[_messages.length - 1 - index];
                return Align(
                  alignment:
                      msg.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: msg.isMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          msg.isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                      children: [
                        Text(
                          msg.content,
                          style: TextStyle(
                            color: msg.isMe ? Colors.white : Colors.black,
                          ),
                        ),
                        if (msg.isMe)
                          Text(
                            msg.status,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white70,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 10.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: "Type a message..."),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
