// To parse this JSON data, do
//
//     final ProfileFailedResponse = ProfileFailedResponseFromJson(jsonString);

import 'dart:convert';

ProfileFailedResponse ProfileFailedResponseFromJson(String str) =>
    ProfileFailedResponse.fromJson(json.decode(str));

String ProfileFailedResponseToJson(ProfileFailedResponse data) =>
    json.encode(data.toJson());

class ProfileFailedResponse {
  String? message;
  int? statusCode;

  ProfileFailedResponse({
    this.message,
    this.statusCode,
  });

  ProfileFailedResponse copyWith({
    String? message,
    int? statusCode,
  }) =>
      ProfileFailedResponse(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
      );

  factory ProfileFailedResponse.fromJson(Map<String, dynamic> json) =>
      ProfileFailedResponse(
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
      };
}
