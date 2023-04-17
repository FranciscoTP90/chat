import 'package:chat_app/domain/models/chat_rooms_response.dart';
import 'package:chat_app/domain/models/login_response.dart';
import 'package:chat_app/domain/models/mensajes_response.dart';

import '../models/user.dart';

abstract class IChatRepository {
  Future<UserModel> fetchLogin(
      {required String email,
      required String password,
      required bool rememberMe});

  Future<String?> fetchToken();

  Future<void> fetchDeleteToken();

  Future<List<Usuario>> fetchUsers();
  Future<List<ChatsRoom>> fetchChatsRooms(String uid);
//el id del usuario que quiero leer los mensajes(que no soy yo)
  Future<List<Mensaje>> fetchMensajes(
      {required String paraUID, required String miUID});

  Future<UserModel> fetchUser();
}
