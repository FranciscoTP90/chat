import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/models/mensajes_response.dart';
import 'package:chat_app/domain/models/user.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/repositories/i_chat_repository.dart';
import '../view/components/chat_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._iChatRepository) : super(ChatState.initialState()) {
    // on<_SendMessage>(_sendMessage);
    // on<_SetMensajes>(_setMensajes);
    // on<_SetMensaje>(_setMensaje);
    on<_SelectUser>(_selectUser);
    on<_GetChatMessages>(_getChatMessages);
    on<_AddMessage>(_addMessage);
    on<_SetMessages>(_setMessages);
    on<_SetMessage>(_setMessage);
  }
  final IChatRepository _iChatRepository;

  late StreamController<Mensaje> _streamController;
  StreamController<Mensaje> get streamController => _streamController;

  initStream() {
    _streamController = StreamController.broadcast();
    _streamController.stream.listen((Mensaje mensaje) {
      // state.mensajes.add(mensaje);
      log("AAAAAAAAAAAAAAAA");
      // add(ChatEvent.onAddMessage(mensaje));
    }, onDone: () {}, onError: (error) {});
  }

  @override
  Future<void> close() {
    _streamController.close();
    return super.close();
  }

  void _selectUser(_SelectUser event, Emitter<ChatState> emit) {
    emit(state.copyWith(userPara: event.user));
  }

  void _getChatMessages(_GetChatMessages event, Emitter<ChatState> emit) async {
    try {
      emit(state.copyWith(
          mensajes: [],
          historyStatus: HistoryStatus.loading,
          messagesWidgets: []));

      final mensajes = await _iChatRepository.fetchMensajes(
          paraUID: state.userPara!.uid, miUID: event.miUID);

      emit(state.copyWith(
          mensajes: mensajes, historyStatus: HistoryStatus.success));
    } catch (e) {
      log("$e");
      emit(state.copyWith(mensajes: [], historyStatus: HistoryStatus.error));
    }
  }

  void _setMessages(_SetMessages event, Emitter<ChatState> emit) {
    List<ChatMessage> tempList = [];
    tempList.insertAll(0, event.iterable);
    emit(state.copyWith(messagesWidgets: tempList));
  }

  void _setMessage(_SetMessage event, Emitter<ChatState> emit) {
    List<ChatMessage> tempList = [...state.messagesWidgets];
    tempList.insert(0, event.messageWidget);
    emit(state.copyWith(messagesWidgets: tempList));
  }

  void _addMessage(_AddMessage event, Emitter<ChatState> emit) {
    final List<Mensaje> msgList = [...state.mensajes, event.message];
    // msgList.insert(0, event.message);
    log("PASE POR AQUI");
    emit(state.copyWith(mensajes: msgList));
  }

  //el id del usuario que quiero leer los mensajes(que no soy yo)
  // Future<List<Mensaje>> getChat(String uid) async {
  //   try {
  //     final mensajes = await _iChatRepository.fetchMensajes(uid);
  //     return mensajes;
  //   } catch (e) {
  //     log("ERROR GET CHAT $e");

  //     return [];
  //   }
  // }
}
