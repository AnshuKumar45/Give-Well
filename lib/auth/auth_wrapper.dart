import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/views/auth/login_page.dart';
import 'package:fundraiser_app/views/navigation_wrapper.dart';
import 'package:get/get.dart';

class AuthWrapper {
  final _authController = Get.put(AuthController());
  // String? _email;
  User? _user;
  Widget navigateUser() {
    _user = _authController.user.value;

    if (_user != null) {
      return NavigationWrapper();
    } else {
      return const LoginPage();
    }
  }

  void fetchUser() async {
    _user = _authController.user.value;
    // _email = await LocalStorage.getUserEmail();
  }
}
