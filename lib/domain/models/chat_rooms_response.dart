// To parse this JSON data, do
//
//     final chatRomsResponse = chatRomsResponseFromMap(jsonString);

import 'package:chat_app/domain/models/user.dart';
import 'dart:convert';

class ChatRomsResponse {
  ChatRomsResponse({
    required this.chatsRooms,
  });

  final List<ChatsRoom> chatsRooms;

  factory ChatRomsResponse.fromJson(String str) =>
      ChatRomsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatRomsResponse.fromMap(Map<String, dynamic> json) =>
      ChatRomsResponse(
        chatsRooms: List<ChatsRoom>.from(
            json["chats_rooms"].map((x) => ChatsRoom.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "chats_rooms": List<dynamic>.from(chatsRooms.map((x) => x.toMap())),
      };
}

class ChatsRoom {
  ChatsRoom({
    required this.mensaje,
    required this.createdAt,
    required this.usuario,
  });

  final String mensaje;
  final DateTime createdAt;
  final Usuario usuario;

  factory ChatsRoom.fromJson(String str) => ChatsRoom.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatsRoom.fromMap(Map<String, dynamic> json) => ChatsRoom(
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
        usuario: Usuario.fromMap(json["usuario"]),
      );

  Map<String, dynamic> toMap() => {
        "mensaje": mensaje,
        "createdAt": createdAt.toIso8601String(),
        "usuario": usuario.toMap(),
      };
}
