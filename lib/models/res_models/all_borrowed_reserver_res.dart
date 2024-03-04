import 'dart:convert';

List<AllBorrowedOrReserverdRes> allBorrowedOrReserverdResFromJson(String str) => List<AllBorrowedOrReserverdRes>.from(json.decode(str).map((x) => AllBorrowedOrReserverdRes.fromJson(x)));

String allBorrowedOrReserverdResToJson(List<AllBorrowedOrReserverdRes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllBorrowedOrReserverdRes {
  final String id;
  final BookId bookId;
  final UserId userId;
  final bool isBorrowed;
  final bool isReturned;
  final bool isReserved;
  final DateTime borrowedDate;
  final DateTime dueDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  AllBorrowedOrReserverdRes({
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
    required this.v,
  });

  factory AllBorrowedOrReserverdRes.fromJson(Map<String, dynamic> json) => AllBorrowedOrReserverdRes(
    id: json["_id"],
    bookId: BookId.fromJson(json["bookId"]),
    userId: UserId.fromJson(json["userId"]),
    isBorrowed: json["isBorrowed"],
    isReturned: json["isReturned"],
    isReserved: json["isReserved"],
    borrowedDate: DateTime.parse(json["borrowedDate"]),
    dueDate: DateTime.parse(json["dueDate"]),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookId": bookId.toJson(),
    "userId": userId.toJson(),
    "isBorrowed": isBorrowed,
    "isReturned": isReturned,
    "isReserved": isReserved,
    "borrowedDate": borrowedDate.toIso8601String(),
    "dueDate": dueDate.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
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
  final List<Id> borrowedUsers;
  final List<dynamic> reservedUsers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

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
    required this.v,
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
    borrowedUsers: List<Id>.from(json["borrowedUsers"].map((x) => idValues.map[x]!)),
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
    "borrowedUsers": List<dynamic>.from(borrowedUsers.map((x) => idValues.reverse[x])),
    "reservedUsers": List<dynamic>.from(reservedUsers.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

enum Id {
  THE_65_DB4779517_DA96_BBEC5_F42_F,
  THE_65_DEDCAC8_EA765_E1_AFED20_D2,
  THE_65_DEE729_A640_D0_DE1_B758636
}

final idValues = EnumValues({
  "65db4779517da96bbec5f42f": Id.THE_65_DB4779517_DA96_BBEC5_F42_F,
  "65dedcac8ea765e1afed20d2": Id.THE_65_DEDCAC8_EA765_E1_AFED20_D2,
  "65dee729a640d0de1b758636": Id.THE_65_DEE729_A640_D0_DE1_B758636
});

class UserId {
  final Id id;
  final String firstName;
  final String lastName;
  final String oneSignalId;
  final String email;
  final String password;
  final bool isLibrarian;
  final String profile;
  final List<String> borrowedBooks;
  final List<dynamic> reservedBooks;
  final int totalBooks;
  final String psid;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  UserId({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.oneSignalId,
    required this.email,
    required this.password,
    required this.isLibrarian,
    required this.profile,
    required this.borrowedBooks,
    required this.reservedBooks,
    required this.totalBooks,
    required this.psid,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: idValues.map[json["_id"]]!,
    firstName: json["firstName"],
    lastName: json["lastName"],
    oneSignalId: json["oneSignalId"],
    email: json["email"],
    password: json["password"],
    isLibrarian: json["isLibrarian"],
    profile: json["profile"],
    borrowedBooks: List<String>.from(json["borrowedBooks"].map((x) => x)),
    reservedBooks: List<dynamic>.from(json["reservedBooks"].map((x) => x)),
    totalBooks: json["totalBooks"],
    psid: json["PSID"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": idValues.reverse[id],
    "firstName": firstName,
    "lastName": lastName,
    "oneSignalId": oneSignalId,
    "email": email,
    "password": password,
    "isLibrarian": isLibrarian,
    "profile": profile,
    "borrowedBooks": List<dynamic>.from(borrowedBooks.map((x) => x)),
    "reservedBooks": List<dynamic>.from(reservedBooks.map((x) => x)),
    "totalBooks": totalBooks,
    "PSID": psid,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
