import 'dart:convert';

ProductListFailedResponse ProductListFailedResponseFromJson(String str) =>
    ProductListFailedResponse.fromJson(json.decode(str));

String ProductListFailedResponseToJson(ProductListFailedResponse data) =>
    json.encode(data.toJson());

class ProductListFailedResponse {
  String? message;
  int? statusCode;
  Map<String, dynamic>? additionalData; // To handle any unknown fields

  ProductListFailedResponse({
    this.message,
    this.statusCode,
    this.additionalData,
  });

  ProductListFailedResponse copyWith({
    String? message,
    int? statusCode,
    Map<String, dynamic>? additionalData,
  }) =>
      ProductListFailedResponse(
        message: message ?? this.message,
        statusCode: statusCode ?? this.statusCode,
        additionalData: additionalData ?? this.additionalData,
      );

  factory ProductListFailedResponse.fromJson(Map<String, dynamic> json) =>
      ProductListFailedResponse(
        message: json["message"],
        statusCode: json["statusCode"],
        additionalData: json["additionalData"] != null
            ? Map<String, dynamic>.from(json)
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "statusCode": statusCode,
        if (additionalData != null) ...additionalData!,
      };
}
