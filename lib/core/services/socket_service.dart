// import 'package:buytx/core/common/singletons/cache_helper.dart';
// import 'package:buytx/core/services/injection_container.dart';
// import 'package:buytx/src/chat/presentaion/bloc/getMessages/messages_bloc.dart';
// import 'package:buytx/src/chat/presentaion/bloc/getMessages/messsages_events.dart';
// import 'package:buytx/src/chat/presentaion/widgets/status_message.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketService {
//   static final SocketService _instance = SocketService._internal();
//   factory SocketService() => _instance;

//   late IO.Socket _socket;

//   SocketService._internal() {
//     initSoket();
//   }

//   initSoket() async {
//     String? token = sl<CacheHelper>().getSessionToken();

//     _socket = IO.io(
//       "https://professional-audrye-mohammedalakkhras-c3be0efd.koyeb.app",
//       IO.OptionBuilder()
//           .setTransports(['websocket'])
//           .enableAutoConnect()
//           .enableForceNew()
//           .setAuth({'token': token})
//           .build(),
//     );

//     _socket.connect();

//     _socket.onConnect((_) {
//       print('Socket connect : ${_socket.id}');
//     });

//     _socket.onDisconnect((_) {
//       print('Socket disconnect ');
//     });

//     _socket.emit('signin', token);
//   }

//   IO.Socket get socket => _socket;
// }
