import 'dart:convert';

List<SearchUserResponseModel> searchUserResponseModelFromJson(String str) => List<SearchUserResponseModel>.from(json.decode(str).map((x) => SearchUserResponseModel.fromJson(x)));

String searchUserResponseModelToJson(List<SearchUserResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchUserResponseModel {
  final String id;
  final String firstName;
  final String lastName;
  final String oneSignalId;
  final String email;
  final bool isLibrarian;
  final String profile;
  final List<dynamic> borrowedBooks;
  final List<dynamic> reservedBooks;
  final int totalBooks;
  final String psid;
  final DateTime createdAt;
  final DateTime updatedAt;

  SearchUserResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.oneSignalId,
    required this.email,
    required this.isLibrarian,
    required this.profile,
    required this.borrowedBooks,
    required this.reservedBooks,
    required this.totalBooks,
    required this.psid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SearchUserResponseModel.fromJson(Map<String, dynamic> json) => SearchUserResponseModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    oneSignalId: json["oneSignalId"],
    email: json["email"],
    isLibrarian: json["isLibrarian"],
    profile: json["profile"],
    borrowedBooks: List<dynamic>.from(json["borrowedBooks"].map((x) => x)),
    reservedBooks: List<dynamic>.from(json["reservedBooks"].map((x) => x)),
    totalBooks: json["totalBooks"],
    psid: json["PSID"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "oneSignalId": oneSignalId,
    "email": email,
    "isLibrarian": isLibrarian,
    "profile": profile,
    "borrowedBooks": List<dynamic>.from(borrowedBooks.map((x) => x)),
    "reservedBooks": List<dynamic>.from(reservedBooks.map((x) => x)),
    "totalBooks": totalBooks,
    "PSID": psid,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
