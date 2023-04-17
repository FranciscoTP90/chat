import 'dart:developer';

import 'package:chat_app/data/data_providers/local/i_local_data_provider.dart';
import 'package:chat_app/domain/models/chat_rooms_response.dart';
import 'package:chat_app/domain/models/login_response.dart';
import 'package:chat_app/domain/models/mensajes_response.dart';
import 'package:chat_app/domain/repositories/i_chat_repository.dart';

import '../../domain/models/user.dart';
import '../data_providers/remote/i_remote_data_provider.dart';

class ChatRepository implements IChatRepository {
  ChatRepository(
      {required IRemoteDataProvider iRemoteDataProvider,
      required ILocalProvider iLocalProvider})
      : _iRemoteDataProvider = iRemoteDataProvider,
        _iLocalProvider = iLocalProvider;

  final IRemoteDataProvider _iRemoteDataProvider;
  final ILocalProvider _iLocalProvider;

  @override
  Future<UserModel> fetchLogin(
      {required String email,
      required String password,
      required bool rememberMe}) async {
    try {
      final UserModel =
          await _iRemoteDataProvider.getLogin(email: email, password: password);

      if (rememberMe) {
        await _iLocalProvider.saveToken(UserModel.token);
      }
      return UserModel;
    } catch (e) {
      log("$e");
      throw '$e';
    }
  }

  @override
  Future<String?> fetchToken() async {
    try {
      String? token = await _iLocalProvider.readToken();
      return token;
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<void> fetchDeleteToken() async {
    try {
      await _iLocalProvider.deleteToken();
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<List<Usuario>> fetchUsers() async {
    try {
      final token = await fetchToken();
      final users = await _iRemoteDataProvider.getUsers(token!);
      return users;
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<List<ChatsRoom>> fetchChatsRooms(String uid) async {
    try {
      final token = await fetchToken();
      final chatsRooms =
          await _iRemoteDataProvider.getChatsRooms(token: token!, uid: uid);
      return chatsRooms;
    } catch (e) {
      throw "$e";
    }
  }

//el id del usuario que quiero leer los mensajes(que no soy yo)
  @override
  Future<List<Mensaje>> fetchMensajes(
      {required String paraUID, required String miUID}) async {
    try {
      final token = await fetchToken();
      final mensajes = await _iRemoteDataProvider.getMensajes(
          paraUID: paraUID, miUID: miUID, token: token!);
      return mensajes;
    } catch (e) {
      throw "$e";
    }
  }

  @override
  Future<UserModel> fetchUser() async {
    try {
      final token = await fetchToken();
      final UserModel userModel = await _iRemoteDataProvider.getUser(token!);

      await _iLocalProvider.saveToken(userModel.token);

      return userModel;
    } catch (e) {
      throw "$e";
    }
  }
}
