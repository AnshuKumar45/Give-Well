import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/widgets/comment_card.dart';
import 'package:fundraiser_app/widgets/form_field_input.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

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
      body: CommentCard(),
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
                onPressed: () {},
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
