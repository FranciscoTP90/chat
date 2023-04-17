import 'dart:developer';

import 'package:chat_app/data/data_providers/remote/i_remote_data_provider.dart';
import 'package:chat_app/domain/models/chat_rooms_response.dart';
import 'package:chat_app/domain/models/login_response.dart';
import 'package:chat_app/domain/models/mensajes_response.dart';
import 'package:chat_app/domain/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../domain/models/users_response.dart';

class DioDataProvider implements IRemoteDataProvider {
  DioDataProvider({required Dio client})
      : _client = Dio(BaseOptions(
            baseUrl: "${dotenv.env['URL_BASE']}:${dotenv.env['PORT']}/api/"));

  final Dio _client;

  @override
  Future<UserModel> getLogin({
    required String email,
    required String password,
  }) async {
    try {
      log("$email - $password");
      final response =
          await _client.post<Map<String, dynamic>>('auth/login-email', data: {
        "email": email,
        "password": password,
      });

      if (response.statusCode == 200 && response.data != null) {
        // log("${response.statusCode} - ${response.data}");

        return compute(_parseUserModel, response.data!);
      }
      if (response.statusCode == 403 || response.statusCode == 500) {
        throw Exception(
            'code: ${response.statusCode}, msg: ${response.data!["msg"]}');
      }
      throw Exception('code: ${response.statusCode}, msg: Error desconocido');
    } catch (e) {
      // log("Error $e");
      rethrow;
    }
  }

  @override
  Future<List<Usuario>> getUsers(String token) async {
    try {
      final response = await _client.get<Map<String, dynamic>>("usuarios",
          options: Options(headers: {"tokensito": token}));
      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseUsersResponse, response.data!);
      }
      // if (response.statusCode == 401) {
      throw Exception(
          'code: ${response.statusCode}, msg: ${response.data!["msg"]}');
      // }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatsRoom>> getChatsRooms(
      {required String token, required String uid}) async {
    try {
      final response = await _client.get<Map<String, dynamic>>(
          "mensajes/chats/$uid",
          options: Options(headers: {"tokensito": token}));
      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseChatRomsResponse, response.data!);
      }
      // if (response.statusCode == 401) {
      throw Exception(
          'code: ${response.statusCode}, msg: ${response.data!["msg"]}');
      // }
    } catch (e) {
      rethrow;
    }
  }

//el id del usuario que quiero leer los mensajes(que no soy yo)
  @override
  Future<List<Mensaje>> getMensajes(
      {required String paraUID,
      required String miUID,
      required String token}) async {
    try {
      log("MI UID: $miUID PARA $paraUID");
      final response = await _client.get<Map<String, dynamic>>(
          "mensajes/$miUID",
          options: Options(headers: {"tokensito": token}),
          queryParameters: {'para': paraUID});
      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseMensaje, response.data!);
      }
      throw Exception(
          'code: ${response.statusCode}, msg: Error al obtener mensajes');
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> getUser(String token) async {
    try {
      final response = await _client.get<Map<String, dynamic>>('usuarios/user',
          options: Options(headers: {"tokensito": token}));

      if (response.statusCode == 200 && response.data != null) {
        return compute(_parseUserModel, response.data!);
      }
      if (response.statusCode == 401 || response.statusCode == 500) {
        throw Exception(
            'code: ${response.statusCode}, msg: ${response.data!["msg"]}');
      }
      throw Exception('code: ${response.statusCode}, msg: Error desconocido');
    } catch (e) {
      rethrow;
    }
  }
}

UserModel _parseUserModel(Map<String, dynamic> responseData) {
  final userModel = UserModel.fromMap(responseData);
  return userModel;
}

List<Usuario> _parseUsersResponse(Map<String, dynamic> responseData) {
  final usersResponse = UsersResponse.fromMap(responseData);
  return usersResponse.usuarios;
}

List<ChatsRoom> _parseChatRomsResponse(Map<String, dynamic> responseData) {
  final chatRomsResponse = ChatRomsResponse.fromMap(responseData);
  return chatRomsResponse.chatsRooms;
}

List<Mensaje> _parseMensaje(Map<String, dynamic> responseData) {
  final MensajesResponse msgResp = MensajesResponse.fromMap(responseData);
  return msgResp.mensajes;
}
