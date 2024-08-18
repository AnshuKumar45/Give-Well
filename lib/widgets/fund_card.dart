import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/database/firebase_post_service.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:get/get.dart';

class FundCard extends StatelessWidget {
  final snap;
  FundCard({super.key, required this.snap});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    String photoUrl = (snap['photoUrl'] == '')
        ? 'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg?t=st=1723963444~exp=1723967044~hmac=4de1e61719b003b21114b7a5a51c1dec5759211b80c107a12994eb16e5cd3a52&w=740'
        : snap['photoUrl'];
    bool isLiked = Get.put(false);

    return Card(
      color: AppColor.primaryBackgroundW,
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with fund name and more icon
            Row(
              children: [
                Expanded(
                  child: Text(
                    snap['fundName'],
                    style: TextStyle(
                      fontSize: 25,
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
              'Details: ${snap['description']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Needed Amount: ${snap['amount']}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'UPI: ${snap['upi']}',
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
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),

            // Upvote, Comment, Donate, Chat Section
            Row(
              children: [
                IconButton(
                  onPressed: () async {
                    PostMethods().updateLike(snap['fundId'],
                        _authController.userDetails.value!.uid, snap['upvote']);
                    (isLiked == false) ? true : false;
                  },
                  icon: (isLiked == false)
                      ? const Icon(
                          Icons.favorite_border_outlined,
                          color: Colors.redAccent,
                        )
                      : const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                ),
                IconButton(
                  onPressed: () {},
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
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.chat_outlined,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Description and Comments Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${snap['upvote'].length} votes',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(color: Colors.black),
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
                    onTap: () {},
                    child: const Text(
                      'View all 100 comments',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 119, 117, 117),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${snap['date']}',
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
