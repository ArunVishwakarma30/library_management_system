import 'dart:convert';

UploadBookReqModel uploadBookReqModelFromJson(String str) => UploadBookReqModel.fromJson(json.decode(str));

String uploadBookReqModelToJson(UploadBookReqModel data) => json.encode(data.toJson());

class UploadBookReqModel {
  final String bookName;
  final String bookDescription;
  final String authorName;
  final String coverImage;
  final int quantity;
  final int available;
  final int publishYear;
  final String publisher;
  final String language;
  final String edition;
  final String pageCount;
  final String semCategoty;

  UploadBookReqModel({
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
  });

  factory UploadBookReqModel.fromJson(Map<String, dynamic> json) => UploadBookReqModel(
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
  );

  Map<String, dynamic> toJson() => {
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
  };
}
