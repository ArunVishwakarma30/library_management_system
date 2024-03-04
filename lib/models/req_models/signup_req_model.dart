import 'dart:convert';

SignUpReqModel signUpReqModelFromJson(String str) => SignUpReqModel.fromJson(json.decode(str));

String signUpReqModelToJson(SignUpReqModel data) => json.encode(data.toJson());

class SignUpReqModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final bool isLibrarian;
  final int psid;

  SignUpReqModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.isLibrarian,
    required this.psid,
  });

  factory SignUpReqModel.fromJson(Map<String, dynamic> json) => SignUpReqModel(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    isLibrarian: json["isLibrarian"],
    psid: json["PSID"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "isLibrarian": isLibrarian,
    "PSID": psid,
  };
}
