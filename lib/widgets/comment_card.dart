import 'package:flutter/material.dart';
import 'package:fundraiser_app/database/firebase_comment_service.dart';
import 'package:fundraiser_app/utils/text_styles.dart';

class CommentCard extends StatefulWidget {
  final snap;
  final authcontroller;
  const CommentCard(
      {super.key, required this.snap, required this.authcontroller});

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
                "https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg"),
            radius: 18,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "username ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        TextSpan(
                          text: "${widget.snap['comment']}",
                          style: const TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child:
                        text("${widget.snap['publishDate']}", Colors.black, 12),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: () async {
                    CommentMethods().updateLike(
                        widget.snap['fundId'],
                        widget.snap['commentId'],
                        widget.authcontroller.userDetails.value!.uid,
                        widget.snap['like']);
                  },
                  child: widget.snap['like'].contains(
                          widget.authcontroller.userDetails.value!.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          size: 16,
                        )
                      : const Icon(
                          Icons.favorite_outline_rounded,
                          size: 16,
                        ),
                ),
              ),
              text(
                  widget.snap['like'].length > 0
                      ? "${widget.snap['like'].length}"
                      : "",
                  Colors.grey,
                  12)
            ],
          ),
        ],
      ),
    );
  }
}
