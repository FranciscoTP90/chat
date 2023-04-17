import 'dart:convert';

class Usuario {
  Usuario(
      {required this.uid,
      required this.email,
      this.name = "",
      required this.active,
      this.imgProfile = "",
      required this.role,
      required this.createdAt,
      required this.updatedAt,
      required this.online});

  final String uid;
  final String email;
  final String? name;
  final bool active;
  final String? imgProfile;
  final String role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool online;

  factory Usuario.fromJson(String str) => Usuario.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuario.fromMap(Map<String, dynamic> json) => Usuario(
      uid: json["uid"],
      email: json["email"],
      name: json["name"] ?? '',
      active: json["active"],
      imgProfile: json["imgProfile"] ?? '',
      role: json["role"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      online: json["online"]);

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "email": email,
        "name": name ?? '',
        "active": active,
        "imgProfile": imgProfile ?? '',
        "role": role,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "online": online
      };
}
