import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryBackgroundW,
      body: const Center(
        child: Text('H O M E P A G E'),
      ),
    );
  }
}
