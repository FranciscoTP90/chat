// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'socket_bloc.dart';

enum ServerStatus { Online, Offline, Connecting }

class SocketState extends Equatable {
  const SocketState({
    required this.serverStatus,
    // this.socket,
  });

  final ServerStatus serverStatus;
  // final IO.Socket? socket;

  factory SocketState.initialState() =>
      const SocketState(serverStatus: ServerStatus.Connecting);

  @override
  List<dynamic> get props => [serverStatus];

  SocketState copyWith({
    ServerStatus? serverStatus,
  }) {
    return SocketState(
      serverStatus: serverStatus ?? this.serverStatus,
    );
  }
}

extension SocketStateX on SocketState {
  // IO.Socket? get getSocket => socket;
  ServerStatus get getServerStatus => serverStatus;
  //Para acortar - pero para dejar de escuchar se sigue usando el getSocket
  // Function get getEmit => socket!.emit;
}
