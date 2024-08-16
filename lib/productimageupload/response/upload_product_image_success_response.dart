import 'dart:convert';

List<FileResponseSuccess> fileResponseSuccessFromJson(String str) =>
    List<FileResponseSuccess>.from(
        json.decode(str).map((x) => FileResponseSuccess.fromJson(x)));

String fileResponseSuccessToJson(List<FileResponseSuccess> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FileResponseSuccess {
  String originalname;
  String filename;
  String location;

  FileResponseSuccess({
    required this.originalname,
    required this.filename,
    required this.location,
  });

  FileResponseSuccess copyWith({
    String? originalname,
    String? filename,
    String? location,
  }) =>
      FileResponseSuccess(
        originalname: originalname ?? this.originalname,
        filename: filename ?? this.filename,
        location: location ?? this.location,
      );

  factory FileResponseSuccess.fromJson(Map<String, dynamic> json) =>
      FileResponseSuccess(
        originalname: json["originalname"],
        filename: json["filename"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "originalname": originalname,
        "filename": filename,
        "location": location,
      };
}
