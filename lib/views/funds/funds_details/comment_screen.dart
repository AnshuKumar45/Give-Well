import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/database/firebase_comment_service.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/utils/text_styles.dart';
import 'package:fundraiser_app/widgets/comment_card.dart';
import 'package:fundraiser_app/widgets/form_field_input.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  final authController;
  const CommentScreen(
      {super.key, required this.snap, required this.authController});

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController commentController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        title: Text(
          "Comment Section",
          style: GoogleFonts.poppins(
            fontSize: 20,
            color: AppColor.textAccentB,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('fund')
            .doc(widget.snap['fundId'])
            .collection('comments')
            .orderBy('publishDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
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
          return ListView.builder(
              itemCount: (snapshot.data! as dynamic).docs.length,
              itemBuilder: (context, index) => CommentCard(
                    snap: snapshot.data!.docs[index].data(),authcontroller:widget.authController,
                  ));
        },
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          padding: const EdgeInsets.only(right: 8.0, left: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832_1280.jpg"),
                radius: 12,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
                  child: buildInputField(
                      controller: commentController, label: "Add a comment"),
                ),
              ),
              TextButton(
                onPressed: () async {
                  CommentMethods().post(
                      userName:
                          widget.authController.userDetails.value!.displayName!,
                      text: commentController.text,
                      publishDate: DateTime.now().toString().substring(0, 11),
                      profilePic: widget.snap['photoUrl'],
                      fundId: widget.snap['fundId'],
                      userId: widget.authController.userDetails.value!.uid);
                  commentController.clear();
                },
                child: Text(
                  "Post",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: AppColor.primary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
