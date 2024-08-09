import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    debugPrint(_authController.user.value!.displayName);
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundW,
      body: const Center(
        child: Text('H O M E P A G E'),
      ),
    );
  }
}
