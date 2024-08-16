import 'dart:convert';

AddProductFailedResponse addProductFailedResponseFromJson(String str) =>
    AddProductFailedResponse.fromJson(json.decode(str));

String addProductFailedResponseToJson(AddProductFailedResponse data) =>
    json.encode(data.toJson());

class AddProductFailedResponse {
  List<String>? message;
  String? error;
  int? statusCode;

  AddProductFailedResponse({
    this.message,
    this.error,
    this.statusCode,
  });

  AddProductFailedResponse copyWith({
    List<String>? message,
    String? error,
    int? statusCode,
  }) =>
      AddProductFailedResponse(
        message: message ?? this.message,
        error: error ?? this.error,
        statusCode: statusCode ?? this.statusCode,
      );

  factory AddProductFailedResponse.fromJson(Map<String, dynamic> json) =>
      AddProductFailedResponse(
        message:
            json["message"] != null ? List<String>.from(json["message"]) : null,
        error: json["error"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "statusCode": statusCode,
      };
}
