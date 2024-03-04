import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/models/req_models/upload_book_req_model.dart';
import 'package:library_management_system/models/res_models/all_borrowed_reserver_res.dart';
import 'package:library_management_system/models/res_models/get_all_books_res_model.dart';
import 'package:library_management_system/models/res_models/search_user_res_model.dart';
import 'package:library_management_system/models/res_models/user_history_res_model.dart';
import 'package:library_management_system/services/helper/dashboard_mange_helper.dart';
import 'package:library_management_system/views/dashboard/dashboard_home_page.dart';

import '../models/req_models/borrow_or_return_req_model.dart';
import '../views/common/snack_bar.dart';

class MenuProvider extends ChangeNotifier {
  late Future<List<GetAllBooksResModel>>? allBooks;
  late Future<List<SearchUserResponseModel>>? searchRes;
  late Future<List<UserHistoryResModel>>? booksHistory;
  late Future<List<AllBorrowedOrReserverdRes>> allBorrowedAndReservedBooks;
  bool _waiting = false;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  bool _searchText = false;

  bool get searchText => _searchText;

  set searchText(bool value) {
    _searchText = value;
    notifyListeners();
  }

  uploadBook(UploadBookReqModel model) {
    LibraryManageHelper.uploadBook(model).then((isAdded) {
      if (isAdded) {
        ShowSnackbar(
            title: "Success",
            message: "Book Successfully Added!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => const LibraryDashboard(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        ShowSnackbar(
            title: "Something went wrong",
            message: "Please try again later!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }

  getAllBooks() {
    allBooks = LibraryManageHelper.getAllBooks();
  }

  searchUser(String query, bool refresh) {
    searchRes = LibraryManageHelper.searchUser(query);
    if (refresh) {
      notifyListeners();
    }
  }

  searchBooks(String query) {
    allBooks = LibraryManageHelper.searchBooks(query);
    notifyListeners();
  }

  userHistory(String userId) {
    booksHistory = LibraryManageHelper.userHistory(userId);
    notifyListeners();
  }

  getAllBorrowedAndReservedBooks(bool isBorrowed) {
    allBorrowedAndReservedBooks = LibraryManageHelper.getAllBorrowedOrReserved(isBorrowed);
  }

  borrowBook(BorrowOrReturnBookReqModel model, bool borrowing) {
    LibraryManageHelper.borrowOrReturnBook(model, borrowing).then((value) {
      if ((value == "Book is already borrowed") ||
          (value == "Borrowed book not found") ||
          (value == "Book is not available right now")) {
        ShowSnackbar(title: "Failed", message: value, icon: Icons.add_alert);
      } else if (value == false) {
        ShowSnackbar(
            title: "Something went wrong",
            message: "Please try again later!",
            icon: Icons.add_alert);
      } else {
        ShowSnackbar(
            title: "Success",
            message: "Book Successfully issued!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);

        Get.offAll(() => const LibraryDashboard());
      }
      setWaiting(false);
    });
  }
}
