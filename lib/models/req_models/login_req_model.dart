import 'dart:convert';

LogInReqModel logInReqModelFromJson(String str) => LogInReqModel.fromJson(json.decode(str));

String logInReqModelToJson(LogInReqModel data) => json.encode(data.toJson());

class LogInReqModel {
  final String email;
  final String password;

  LogInReqModel({
    required this.email,
    required this.password,
  });

  factory LogInReqModel.fromJson(Map<String, dynamic> json) => LogInReqModel(
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
