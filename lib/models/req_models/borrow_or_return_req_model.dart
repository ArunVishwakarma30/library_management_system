import 'dart:convert';

BorrowOrReturnBookReqModel borrowOrReturnBookReqModelFromJson(String str) => BorrowOrReturnBookReqModel.fromJson(json.decode(str));

String borrowOrReturnBookReqModelToJson(BorrowOrReturnBookReqModel data) => json.encode(data.toJson());

class BorrowOrReturnBookReqModel {
  final String bookId;
  final String userId;

  BorrowOrReturnBookReqModel({
    required this.bookId,
    required this.userId,
  });

  factory BorrowOrReturnBookReqModel.fromJson(Map<String, dynamic> json) => BorrowOrReturnBookReqModel(
    bookId: json["bookId"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "bookId": bookId,
    "userId": userId,
  };
}
