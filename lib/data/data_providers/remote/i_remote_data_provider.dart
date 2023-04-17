import 'package:chat_app/domain/models/chat_rooms_response.dart';
import 'package:chat_app/domain/models/login_response.dart';
import 'package:chat_app/domain/models/mensajes_response.dart';
import 'package:chat_app/domain/models/user.dart';

abstract class IRemoteDataProvider {
  Future<UserModel> getLogin({required String email, required String password});

  Future<List<Usuario>> getUsers(String token);

  Future<List<ChatsRoom>> getChatsRooms(
      {required String token, required String uid});

  Future<List<Mensaje>> getMensajes(
      {required String paraUID, required String miUID, required String token});

  Future<UserModel> getUser(String token);
}
