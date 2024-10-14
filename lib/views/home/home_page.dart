import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/controllers/fund_controller.dart';
import 'package:fundraiser_app/database/local_storage.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/widgets/fund_card.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../widgets/custom_overlay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.find<AuthController>();
  final fundController = Get.put(FundController());

  String? email;

  void loadEmail() async {
    email = await LocalStorage.getUserEmail();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadEmail();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Home Page");
    debugPrint("Email of the user: $email");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        elevation: 0,
        title: text('Community', AppColor.primaryBackgroundW, 20,
            fw: FontWeight.w900),
        actions: [
          IconButton(
            onPressed: () {
              CustomOverlay.showToast(
                  context, 'Messenger button tapped ----> Testing the overlay');
            },
            icon: Icon(
              Icons.messenger_outline_rounded,
              color: AppColor.primaryBackgroundW,
              size: 25,
            ),
          ),
        ],
      ),
      backgroundColor: AppColor.primaryBackgroundW.withOpacity(0.95),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: Obx(() {
          // Observing the state from FundController
          if (fundController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                strokeWidth: 5.0,
                valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
              ),
            );
          }

          if (fundController.hasError.value) {
            return Center(
              child: text('Something went wrong. Please try again later.',
                  Colors.redAccent, 16),
            );
          }

          if (fundController.funds.isEmpty) {
            return Center(
              child: text('No funds available at the moment.',
                  AppColor.textAccentW, 16),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 0),
            itemCount: fundController.funds.length,
            itemBuilder: (context, index) {
              var data = fundController.funds[index];
              return FundCard(
                snap: data,
              ).onTap(() {
                debugPrint(data['description'].toString());
              });
            },
            separatorBuilder: (context, index) => const SizedBox(height: 0),
          );
        }),
      ),
    );
  }
}
