import 'package:bloc/bloc.dart';
import 'package:chat_app/domain/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/chat_rooms_response.dart';
import '../../../domain/repositories/i_chat_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this._iChatRepository) : super(HomeState.initialState()) {
    on<_GetUsers>(_getUsers);
    on<_ChangePage>(_changePage);
  }

  final IChatRepository _iChatRepository;

  PageController controller = PageController();

  Future<void> _getUsers(_GetUsers event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(homeStatus: HomeStatus.loading));

      Future<List<Usuario>> futureUsers = _iChatRepository.fetchUsers();
      Future<List<ChatsRoom>> futureChatsRooms =
          _iChatRepository.fetchChatsRooms(event.myUID);

      final futures = await Future.wait([futureUsers, futureChatsRooms]);

      // List<Usuario> users = await _iChatRepository.fetchUsers();
      // List<ChatsRoom> chatsRooms =
      //     await _iChatRepository.fetchChatsRooms(event.myUID);

      emit(state.copyWith(
          homeStatus: HomeStatus.success,
          users: futures[0] as List<Usuario>,
          chatsRooms: futures[1] as List<ChatsRoom>));
    } catch (e) {
      emit(state.copyWith(homeStatus: HomeStatus.error));
    }
  }

  void _changePage(_ChangePage event, Emitter<HomeState> emit) {
    controller.jumpToPage(event.page);
    emit(state.copyWith(page: event.page));
  }
}
