import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/widgets/fund_card.dart';
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
      appBar: AppBar(
        backgroundColor: AppColor.primaryBackgroundW,
        title: text('Community', AppColor.primary, 22),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.messenger_outline_rounded),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('fund').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => const FundCard(),
          );
        },
      ),
    );
  }
}
