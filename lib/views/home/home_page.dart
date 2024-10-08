import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
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
  final controller = Get.find<AuthController>();
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
    debugPrint("Email of the user$email");

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
              color: AppColor.primaryBackgroundW, // Better color matching
              size: 25, // Increased size for better visibility
            ),
          ),
        ],
      ),
      backgroundColor: AppColor.primaryBackgroundW
          .withOpacity(0.95), // Subtle background color
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 5, vertical: 2), // Better padding for layout balance
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('fund')
              .orderBy('date', descending: true)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 5.0,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
                ),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: text('Something went wrong. Please try again later.',
                    Colors.redAccent, 16),
              );
            }

            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: text('No funds available at the moment.',
                    AppColor.textAccentW, 16),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                  vertical: 0), // Extra padding for better spacing
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data();
                return FundCard(
                  snap: data,
                ).onTap(() {
                  debugPrint(data['description'].toString());
                });
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 0), // Space between FundCards
            );
          },
        ),
      ),
    );
  }
}
