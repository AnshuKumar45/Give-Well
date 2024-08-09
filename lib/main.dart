import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/auth/auth_wrapper.dart';
import 'package:fundraiser_app/controllers/navigation_controller.dart';
import 'package:get/get.dart';

void main() async {
  // firebase services are initialized in the main
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(NavigationController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: AuthWrapper().navigateUser(),
    );
  }
}
