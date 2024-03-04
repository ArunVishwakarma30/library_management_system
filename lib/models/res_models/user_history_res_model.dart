import 'dart:convert';

List<UserHistoryResModel> userHistoryResModelFromJson(String str) => List<UserHistoryResModel>.from(json.decode(str).map((x) => UserHistoryResModel.fromJson(x)));

String userHistoryResModelToJson(List<UserHistoryResModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserHistoryResModel {
  final String id;
  final BookId bookId;
  final String userId;
  final bool isBorrowed;
  final bool isReturned;
  final bool isReserved;
  final DateTime borrowedDate;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserHistoryResModel({
    required this.id,
    required this.bookId,
    required this.userId,
    required this.isBorrowed,
    required this.isReturned,
    required this.isReserved,
    required this.borrowedDate,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserHistoryResModel.fromJson(Map<String, dynamic> json) => UserHistoryResModel(
    id: json["_id"],
    bookId: BookId.fromJson(json["bookId"]),
    userId: json["userId"],
    isBorrowed: json["isBorrowed"],
    isReturned: json["isReturned"],
    isReserved: json["isReserved"],
    borrowedDate: DateTime.parse(json["borrowedDate"]),
    dueDate: DateTime.parse(json["dueDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookId": bookId.toJson(),
    "userId": userId,
    "isBorrowed": isBorrowed,
    "isReturned": isReturned,
    "isReserved": isReserved,
    "borrowedDate": borrowedDate.toIso8601String(),
    "dueDate": dueDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class BookId {
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
  final List<String> borrowedUsers;
  final List<dynamic> reservedUsers;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookId({
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
  });

  factory BookId.fromJson(Map<String, dynamic> json) => BookId(
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
    borrowedUsers: List<String>.from(json["borrowedUsers"].map((x) => x)),
    reservedUsers: List<dynamic>.from(json["reservedUsers"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
  };
}
