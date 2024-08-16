// To parse this JSON data, do
//
//     final loginFailedResponse = loginFailedResponseFromJson(jsonString);

import 'dart:convert';

ProfileSuccesResponse ProfileSuccesResponseFromJson(String str) =>
    ProfileSuccesResponse.fromJson(json.decode(str));

String ProfileSuccesResponseToJson(ProfileSuccesResponse data) =>
    json.encode(data.toJson());

class ProfileSuccesResponse {
  int? id;
  String email;
  String password;
  String name;
  String role;
  String avatar;
  DateTime? creationAt;
  DateTime? updatedAt;

  ProfileSuccesResponse({
    this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    this.creationAt,
    this.updatedAt,
  });

  ProfileSuccesResponse copyWith({
    int? id,
    String? email,
    String? password,
    String? name,
    String? role,
    String? avatar,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) =>
      ProfileSuccesResponse(
        id: id ?? this.id,
        email: email ?? this.email,
        password: password ?? this.password,
        name: name ?? this.name,
        role: role ?? this.role,
        avatar: avatar ?? this.avatar,
        creationAt: creationAt ?? this.creationAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProfileSuccesResponse.fromJson(Map<String, dynamic> json) =>
      ProfileSuccesResponse(
        id: json["id"],
        email: json["email"],
        password: json["password"],
        name: json["name"],
        role: json["role"],
        avatar: json["avatar"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
        "name": name,
        "role": role,
        "avatar": avatar,
        "creationAt": creationAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
