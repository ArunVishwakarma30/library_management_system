import 'dart:convert';

List<GetAllBooksResModel> getAllBooksResModelFromJson(String str) => List<GetAllBooksResModel>.from(json.decode(str).map((x) => GetAllBooksResModel.fromJson(x)));

String getAllBooksResModelToJson(List<GetAllBooksResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllBooksResModel {
  final String id;
  final String bookName;
  final String bookDescription;
  final String authorName;
  final String coverImage;
  final int quantity;
  final int available;
  final int publishYear;
  final String publisher;
  final String language;
  final int edition;
  final int pageCount;
  final String semCategoty;
  final List<dynamic> borrowedUsers;
  final List<dynamic> reservedUsers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  GetAllBooksResModel({
    required this.id,
    required this.bookName,
    required this.bookDescription,
    required this.authorName,
    required this.coverImage,
    required this.quantity,
    required this.available,
    required this.publishYear,
    required this.publisher,
    required this.language,
    required this.edition,
    required this.pageCount,
    required this.semCategoty,
    required this.borrowedUsers,
    required this.reservedUsers,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GetAllBooksResModel.fromJson(Map<String, dynamic> json) => GetAllBooksResModel(
    id: json["_id"],
    bookName: json["bookName"],
    bookDescription: json["bookDescription"],
    authorName: json["authorName"],
    coverImage: json["coverImage"],
    quantity: json["quantity"],
    available: json["available"],
    publishYear: json["publishYear"],
    publisher: json["publisher"],
    language: json["language"],
    edition: json["edition"],
    pageCount: json["pageCount"],
    semCategoty: json["semCategoty"],
    borrowedUsers: List<dynamic>.from(json["borrowedUsers"].map((x) => x)),
    reservedUsers: List<dynamic>.from(json["reservedUsers"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookName": bookName,
    "bookDescription": bookDescription,
    "authorName": authorName,
    "coverImage": coverImage,
    "quantity": quantity,
    "available": available,
    "publishYear": publishYear,
    "publisher": publisher,
    "language": language,
    "edition": edition,
    "pageCount": pageCount,
    "semCategoty": semCategoty,
    "borrowedUsers": List<dynamic>.from(borrowedUsers.map((x) => x)),
    "reservedUsers": List<dynamic>.from(reservedUsers.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
