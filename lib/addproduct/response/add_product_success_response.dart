import 'dart:convert';

AddProductSuccessResponse addProductSuccessResponseFromJson(String str) =>
    AddProductSuccessResponse.fromJson(json.decode(str));

String addProductSuccessResponseToJson(AddProductSuccessResponse data) =>
    json.encode(data.toJson());

class AddProductSuccessResponse {
  String title;
  int price;
  String description;
  List<String> images;
  Category category;
  int id;
  DateTime creationAt;
  DateTime updatedAt;

  AddProductSuccessResponse({
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    required this.id,
    required this.creationAt,
    required this.updatedAt,
  });

  AddProductSuccessResponse copyWith({
    String? title,
    int? price,
    String? description,
    List<String>? images,
    Category? category,
    int? id,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) =>
      AddProductSuccessResponse(
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        images: images ?? this.images,
        category: category ?? this.category,
        id: id ?? this.id,
        creationAt: creationAt ?? this.creationAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AddProductSuccessResponse.fromJson(Map<String, dynamic> json) =>
      AddProductSuccessResponse(
        title: json["title"],
        price: json["price"],
        description: json["description"],
        images: List<String>.from(json["images"].map((x) => x)),
        category: Category.fromJson(json["category"]),
        id: json["id"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
        "description": description,
        "images": List<dynamic>.from(images.map((x) => x)),
        "category": category.toJson(),
        "id": id,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Category {
  int id;
  String name;
  String image;
  DateTime creationAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    String? image,
    DateTime? creationAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        creationAt: creationAt ?? this.creationAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        creationAt: DateTime.parse(json["creationAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "creationAt": creationAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
