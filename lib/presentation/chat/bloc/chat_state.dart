// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

enum HistoryStatus { initial, loading, success, error }

class ChatState extends Equatable {
  const ChatState(
      {required this.mensajes,
      required this.userPara,
      required this.historyStatus,
      required this.messagesWidgets});
  final Usuario? userPara;
  final List<Mensaje> mensajes;
  final List<ChatMessage> messagesWidgets;
  final HistoryStatus historyStatus;

  factory ChatState.initialState() => const ChatState(
      mensajes: [],
      userPara: null,
      historyStatus: HistoryStatus.initial,
      messagesWidgets: []);

  @override
  List<dynamic> get props =>
      [userPara, mensajes, historyStatus, messagesWidgets];

  ChatState copyWith(
      {Usuario? userPara,
      List<Mensaje>? mensajes,
      HistoryStatus? historyStatus,
      List<ChatMessage>? messagesWidgets}) {
    return ChatState(
        userPara: userPara ?? this.userPara,
        mensajes: mensajes ?? this.mensajes,
        historyStatus: historyStatus ?? this.historyStatus,
        messagesWidgets: messagesWidgets ?? this.messagesWidgets);
  }
}

// extension ChateExtension on ChatState{
//   String get time => mensajes[index].createdAt
// }

// class ChatState extends Equatable {
//   const ChatState(
//       {required this.mensajes,
//       required this.userPara,
//       required this.historyStatus});
//   final Usuario? userPara;
//   final List<ChatMessage> mensajes;
//   final HistoryStatus historyStatus;

//   factory ChatState.initialState() => const ChatState(
//       mensajes: [], userPara: null, historyStatus: HistoryStatus.initial);

//   @override
//   List<dynamic> get props => [userPara, mensajes, historyStatus];

//   ChatState copyWith(
//       {Usuario? userPara,
//       List<ChatMessage>? mensajes,
//       HistoryStatus? historyStatus}) {
//     return ChatState(
//         userPara: userPara ?? this.userPara,
//         mensajes: mensajes ?? this.mensajes,
//         historyStatus: historyStatus ?? this.historyStatus);
//   }
// }
