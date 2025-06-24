// // SocketBloc Implementation
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:buytx/src/chat/presentaion/bloc/chatsocket/socket_event.dart';
// import 'package:buytx/src/chat/presentaion/bloc/chatsocket/socket_state.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class SocketBloc extends Bloc<SocketEvent, SocketState> {
//   late IO.Socket socket;

//   SocketBloc() : super(SocketInitial()) {
//     on<ConnectSocket>((event, emit) {
//       print("1");
//       socket = IO.io(
//         'https://professional-audrye-mohammedalakkhras-c3be0efd.koyeb.app',
//         <String, dynamic>{
//           'transports': ['websocket'],
//         },
//       );
//       socket.on('connect', (_) => emit(SocketConnected()));
//       socket.on('disconnect', (_) => emit(SocketDisconnected()));
//       socket.on('message', (data) => add(ReceiveMessage(data)));
//     });

//     on<DisconnectSocket>((event, emit) {
//       socket.disconnect();
//       emit(SocketDisconnected());
//     });

//     on<ReceiveMessage>((event, emit) {
//       emit(MessageReceived(event.message));
//     });
//   }
// }
