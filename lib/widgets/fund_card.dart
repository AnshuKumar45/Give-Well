import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/controllers/fund_controller.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/views/funds/funds_details/comment_screen.dart';
import 'package:fundraiser_app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class FundCard extends StatefulWidget {
  final snap;
  const FundCard({super.key, required this.snap});

  @override
  State<FundCard> createState() => _FundCardState();
}

class _FundCardState extends State<FundCard> {
  final _fundController = Get.find<FundController>();
  final _authController = Get.find<AuthController>();
  int commentlen = 0;

  @override
  void initState() {
    super.initState();
    getCommets();
  }

  void getCommets() async {
    try {
      QuerySnapshot commentSnap = await FirebaseFirestore.instance
          .collection('fund')
          .doc(widget.snap['fundId'])
          .collection('comments')
          .get();
      setState(() {
        commentlen = commentSnap.docs.length;
      });
    } catch (e) {
      showCustomSnackbar(title: 'Error', message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String photoUrl = (widget.snap['photoUrl'] == '')
        ? 'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg'
        : widget.snap['photoUrl'];
    String userId = _authController.userDetails.value!.uid;

    return Card(
      color: AppColor.primaryBackgroundW,
      elevation: 8, // Adds a subtle shadow for depth
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with fund name and more icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    widget.snap['fundName'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            InkWell(
                              onTap: () {
                                // Add delete logic
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 16),
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Details Section
            Text(
              widget.snap['description'],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            Text(
              'Amount Needed: ${widget.snap['amount']}',
              style: TextStyle(
                fontSize: 16,
                color: AppColor.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'UPI: ${widget.snap['upi']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 12),

            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                photoUrl,
                height: MediaQuery.of(context).size.height * 0.3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Action Buttons: Upvote, Comment, Donate, Chat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Use controller's method to update the like status
                        _fundController.updateLike(
                            widget.snap['fundId'], userId);
                      },
                      icon: widget.snap['upvote'].contains(userId)
                          ? const Icon(Icons.favorite, color: Colors.redAccent)
                          : const Icon(Icons.favorite_outline_rounded,
                              color: Colors.red),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${widget.snap['upvote'].length} votes',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CommentScreen(
                            snap: widget.snap,
                            authController: _authController,
                          ))),
                  icon: const Icon(
                    Icons.insert_comment_rounded,
                    color: Colors.blueAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.currency_rupee_rounded,
                    color: Colors.greenAccent,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.chat_outlined,
                    color: Colors.orangeAccent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Comments Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black87),
                      children: [
                        TextSpan(
                          text: 'anshu',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              ' commented: Hey, this is the description of the fund.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CommentScreen(
                          authController: _authController,
                          snap: widget.snap,
                        ),
                      ),
                    ),
                    child: Text(
                      'View all $commentlen comments',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 119, 117, 117),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${widget.snap['date']}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
