import 'dart:convert';

FailedImageUploadResponse failedImageUploadResponseFromJson(String str) =>
    FailedImageUploadResponse.fromJson(json.decode(str));

String failedImageUploadResponseToJson(FailedImageUploadResponse data) =>
    json.encode(data.toJson());

class FailedImageUploadResponse {
  int statusCode;
  String message;

  FailedImageUploadResponse({
    required this.statusCode,
    required this.message,
  });

  FailedImageUploadResponse copyWith({
    int? statusCode,
    String? message,
  }) =>
      FailedImageUploadResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
      );

  factory FailedImageUploadResponse.fromJson(Map<String, dynamic> json) =>
      FailedImageUploadResponse(
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
      };
}
