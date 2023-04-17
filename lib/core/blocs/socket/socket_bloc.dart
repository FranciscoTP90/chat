import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  IO.Socket? _socket;
  SocketBloc() : super(SocketState.initialState()) {
    on<_ConnectSocket>(_connectSocket);
    on<_DisconnectSocket>(_disconnectSocket);
    on<_OnConnect>(_onConnect);
    on<_OnDisconnect>(_onDisconnect);

    // _socket?.onConnect((_) {
    //   add(_OnConnect());
    // });
  }
  // final IChatRepository _iChatRepository;

  IO.Socket? get getSocket => _socket;
  Function get getEmit => _socket!.emit;

  void _connectSocket(_ConnectSocket event, Emitter<SocketState> emit) {
    // final token = await _iChatRepository.fetchToken();
    // / Dart client
    _socket = IO.io(
        "http://192.168.1.70:3001",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .setExtraHeaders(
                {'tokensito': event.token}) // for Flutter or Dart VM
            .build());
    // /Si autoconect false entonces
    // socket.connect();
    _socket?.onConnect((_) {
      // log("CONECTADO");
      // emit(state.copyWith(serverStatus: ServerStatus.Online));
      add(SocketEvent.onConnect());
    });
    // socket.on('event', (data) => print(data));
    _socket?.onDisconnect((_) {
      add(SocketEvent.onDisconnect());
      // emit(state.copyWith(serverStatus: ServerStatus.Offline));
    });
  }

  void _disconnectSocket(_DisconnectSocket event, Emitter<SocketState> emit) {
    emit(state.copyWith(serverStatus: ServerStatus.Offline));
    _socket?.dispose();
  }

  void _onConnect(_OnConnect event, Emitter<SocketState> emit) {
    log("CONECTADO");
    emit(state.copyWith(serverStatus: ServerStatus.Online));
  }

  void _onDisconnect(_OnDisconnect event, Emitter<SocketState> emit) {
    log("DESCONECTADO");
    emit(state.copyWith(serverStatus: ServerStatus.Offline));
  }
}
