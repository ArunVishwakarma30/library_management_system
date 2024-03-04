import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:library_management_system/models/req_models/login_req_model.dart';
import 'package:library_management_system/models/req_models/signup_req_model.dart';
import 'package:library_management_system/services/helper/auth_helper.dart';
import 'package:library_management_system/views/dashboard/dashboard_home_page.dart';
import 'package:library_management_system/views/menu_screeens/home_page.dart';
import 'package:library_management_system/views/menu_screeens/menu_page.dart';

import '../views/common/snack_bar.dart';

class AuthProvider extends ChangeNotifier {
  bool _secure = true;
  bool _waiting = false;

  get secure => _secure;

  get waiting => _waiting;

  void setWaiting(bool value) {
    _waiting = value;
    notifyListeners();
  }

  void setSecure() {
    if (_secure) {
      _secure = false;
    } else {
      _secure = true;
    }
    notifyListeners();
  }

  signUp(SignUpReqModel model) {
    AuthHelper.signUp(model).then((responseStatusCode) {
      if (responseStatusCode == 201) {
        ShowSnackbar(
            title: "Success",
            message: "Successfully Registered!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => kIsWeb ? const LibraryDashboard() : const MenuPage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else if (responseStatusCode == 409) {
        ShowSnackbar(
            title: "Sign Up Failed",
            message: "Email already exists",
            icon: Icons.error_outline_outlined);
      } else {
        ShowSnackbar(
            title: "Sign Up Failed",
            message: "Please check your credentials!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }

  login(LogInReqModel model) {
    AuthHelper.login(model).then((response) {
      if (response) {
        ShowSnackbar(
            title: "Success",
            message: "Successfully logged In!",
            icon: Icons.done_outline,
            bgColor: Colors.green,
            textColor: Colors.white);
        Get.offAll(() => kIsWeb ? const LibraryDashboard() : const MenuPage(),
            transition: Transition.fadeIn,
            duration: const Duration(seconds: 2));
      } else {
        ShowSnackbar(
            title: "Invalid login details",
            message: "Please check your credentials!",
            icon: Icons.add_alert);
      }
      setWaiting(false);
    });
  }
}
