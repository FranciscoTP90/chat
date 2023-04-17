// To parse this JSON data, do
//
//     final usersResponse = usersResponseFromMap(jsonString);

import 'package:chat_app/domain/models/user.dart';
import 'dart:convert';

class UsersResponse {
  UsersResponse({
    required this.usuarios,
  });

  final List<Usuario> usuarios;

  factory UsersResponse.fromJson(String str) =>
      UsersResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory UsersResponse.fromMap(Map<String, dynamic> json) => UsersResponse(
        usuarios:
            List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toMap())),
      };
}
