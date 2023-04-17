// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

abstract class ChatEvent {
  // factory ChatEvent.onSendMsg(ChatModel chat) => _SendMessage(chat: chat);
  // factory ChatEvent.onSetMensajes(Iterable<ChatMessage> iterable) =>
  //     _SetMensajes(iterable);

  // factory ChatEvent.onSetMensaje(ChatMessage message) => _SetMensaje(message);

  factory ChatEvent.onSelectUser(Usuario user) => _SelectUser(user);
  factory ChatEvent.onGetChatMessages(String miUID) => _GetChatMessages(miUID);
  factory ChatEvent.onAddMessage(Mensaje message) => _AddMessage(message);

  factory ChatEvent.onSetMessageWidget(ChatMessage messageWidget) =>
      _SetMessage(messageWidget);

  factory ChatEvent.onSetMessagesWidgets(Iterable<ChatMessage> iterable) =>
      _SetMessages(iterable);
}

// class _SendMessage implements ChatEvent {
//   _SendMessage({required this.chat});

//   final ChatModel chat;
// }

// class _ReceiveMessage implements ChatEvent {}

// class _SetMensajes implements ChatEvent {
//   _SetMensajes(this.iterable);
//   final Iterable<ChatMessage> iterable;
// }

// class _SetMensaje implements ChatEvent {
//   _SetMensaje(this.message);

//   final ChatMessage message;
// }

class _GetChatMessages implements ChatEvent {
  final String miUID;

  _GetChatMessages(this.miUID);
}

class _SelectUser implements ChatEvent {
  final Usuario user;

  _SelectUser(this.user);
}

class _AddMessage implements ChatEvent {
  final Mensaje message;
  _AddMessage(
    this.message,
  );
}

class _SetMessage implements ChatEvent {
  final ChatMessage messageWidget;

  _SetMessage(this.messageWidget);
}

class _SetMessages implements ChatEvent {
  final Iterable<ChatMessage> iterable;

  _SetMessages(this.iterable);
}
