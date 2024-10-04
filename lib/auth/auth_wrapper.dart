import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/views/auth/login_page.dart';
import 'package:fundraiser_app/views/navigation_wrapper.dart';
import 'package:get/get.dart';

import '../database/local_storage.dart'; // Ensure correct import for LocalStorage

class AuthWrapper {
  final AuthController _authController = Get.put(AuthController());
  User? _user;
  String? _email;

  Future<Widget> navigateUser() async {
    _user = _authController.user.value;

    if (_user != null) {
      _email = await LocalStorage.getUserEmail();
      if (_email != null && _email!.isNotEmpty) {
        return NavigationWrapper(); 
      } else {
        return const LoginPage();
      }
    } else {
      return const LoginPage();
    }
  }

  // Optional: This method can be used to explicitly fetch user data when needed
  void fetchUser() async {
    _user = _authController.user.value;
    _email = await LocalStorage.getUserEmail();
  }
}
