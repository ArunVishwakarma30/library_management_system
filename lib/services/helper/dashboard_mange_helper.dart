import 'dart:convert';

import 'package:get/get.dart';
import 'package:library_management_system/models/req_models/borrow_or_return_req_model.dart';
import 'package:library_management_system/models/req_models/upload_book_req_model.dart';
import 'package:library_management_system/models/res_models/all_borrowed_reserver_res.dart';
import 'package:library_management_system/models/res_models/get_all_books_res_model.dart';
import 'package:library_management_system/models/res_models/search_user_res_model.dart';
import 'package:library_management_system/models/res_models/user_history_res_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as https;

import '../config.dart';

class LibraryManageHelper {
  static var client = https.Client();

  // Upload Book to database
  static Future<bool> uploadBook(UploadBookReqModel model) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiURL}${Config.uploadBookUrl}");
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  // get All books
  static Future<List<GetAllBooksResModel>> getAllBooks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiURL}${Config.allBooksUrl}");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var booksRes = getAllBooksResModelFromJson(response.body);
      return booksRes;
    } else {
      throw Exception("Failed to get the books data");
    }
  }

  // get All books
  static Future<List<GetAllBooksResModel>> searchBooks(
      String searchQuery) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiURL}${Config.searchBooks}$searchQuery");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var booksRes = getAllBooksResModelFromJson(response.body);
      return booksRes;
    } else {
      throw Exception("Failed to get the books data");
    }
  }

  // get All books
  static Future<List<UserHistoryResModel>> userHistory(String userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiURL}${Config.userHistory}/$userId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var historyRes = userHistoryResModelFromJson(response.body);
      return historyRes;
    } else {
      throw Exception("Failed to get the user's history data");
    }
  }

  // search user
  static Future<List<SearchUserResponseModel>> searchUser(String query) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    var url = Uri.parse("${Config.apiURL}${Config.searchUser}$query");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var searchRes = searchUserResponseModelFromJson(response.body);
      return searchRes;
    } else {
      throw Exception("Failed to get user data");
    }
  }

  // borrow books
  static Future<dynamic> borrowOrReturnBook(
      BorrowOrReturnBookReqModel model, bool borrowing) async {
    String query = "";
    if (borrowing) {
      query = Config.borrowBooks;
    } else {
      query == Config.returnBooks;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'token': 'Bearer $token'
    }; //indicating that the HTTP request will have a JSON payload.

    var url = Uri.parse("${Config.apiURL}$query");
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 400) {
      Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody['error'];
    } else {
      false;
    }
  }

  // get All books
  static Future<List<AllBorrowedOrReserverdRes>> getAllBorrowedOrReserved(
      bool getBorrowed) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };

    String endPoint = getBorrowed ? Config.allBorrowed : Config.allReserved;
    var url = Uri.parse("${Config.apiURL}$endPoint");
    var response = await client.get(url, headers: requestHeaders);
    if (response.statusCode == 200) {
      var booksRes = allBorrowedOrReserverdResFromJson(response.body);
      print(booksRes.length);
      print(response.body);
      return booksRes;
    } else {
      throw Exception("Failed to get the books data");
    }
  }
}
