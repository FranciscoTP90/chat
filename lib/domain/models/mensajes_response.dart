// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final mensajesResponse = mensajesResponseFromMap(jsonString);

import 'dart:convert';

class MensajesResponse {
  MensajesResponse({
    required this.mensajes,
  });

  final List<Mensaje> mensajes;

  factory MensajesResponse.fromJson(String str) =>
      MensajesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MensajesResponse.fromMap(Map<String, dynamic> json) =>
      MensajesResponse(
        mensajes:
            List<Mensaje>.from(json["mensajes"].map((x) => Mensaje.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "mensajes": List<dynamic>.from(mensajes.map((x) => x.toMap())),
      };
}

class ChatModel {
  final String para;
  final String de;
  final String mensaje;
  ChatModel({
    required this.para,
    required this.de,
    required this.mensaje,
  });
}

class Mensaje {
  Mensaje({
    required this.id,
    required this.para,
    required this.de,
    required this.mensaje,
    required this.createdAt,
  });

  final String id;
  final String para;
  final String de;
  final String mensaje;
  final DateTime createdAt;

  @override
  String toString() => 'De: $de - Para $para - Msj $mensaje';

  factory Mensaje.fromJson(String str) => Mensaje.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mensaje.fromMap(Map<String, dynamic> json) => Mensaje(
        id: json["id"],
        para: json["para"],
        de: json["de"],
        mensaje: json["mensaje"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "para": para,
        "de": de,
        "mensaje": mensaje,
        "updatedAt": createdAt.toIso8601String(),
      };
}
