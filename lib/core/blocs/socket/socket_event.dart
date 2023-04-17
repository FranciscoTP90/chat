part of 'socket_bloc.dart';

abstract class SocketEvent {
  factory SocketEvent.onConnectSocket(String token) => _ConnectSocket(token);
  factory SocketEvent.onDisconnectSocket() => _DisconnectSocket();

  factory SocketEvent.onConnect() => _OnConnect();
  factory SocketEvent.onDisconnect() => _OnDisconnect();
}

class _ConnectSocket implements SocketEvent {
  _ConnectSocket(this.token);
  final String token;
}

class _DisconnectSocket implements SocketEvent {}

class _OnConnect implements SocketEvent {}

class _OnDisconnect implements SocketEvent {}
