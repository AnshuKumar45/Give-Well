import 'package:flutter/material.dart';
import 'package:fundraiser_app/controllers/auth_controller.dart';
import 'package:fundraiser_app/database/firebase_post_service.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:fundraiser_app/views/funds/funds_details/comment_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class FundCardCached extends StatelessWidget {
  final Map<String, dynamic> snap; // Assuming snap is a map for better typing
  FundCardCached({super.key, required this.snap});

  final _authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    String photoUrl = (snap['photoUrl'] == '')
        ? 'https://img.freepik.com/free-vector/no-data-concept-illustration_114360-536.jpg?t=st=1723963444~exp=1723967044~hmac=4de1e61719b003b21114b7a5a51c1dec5759211b80c107a12994eb16e5cd3a52&w=740'
        : snap['photoUrl'];

    String userId = _authController.userDetails.value!.uid;

    return Card(
      color: AppColor.primaryBackgroundW,
      elevation: 8,
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
                    snap['fundName'],
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _showMoreOptions(context),
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Details Section
            _buildDetailsSection(),

            // Image Section
            _buildImageSection(photoUrl, context),

            const SizedBox(height: 12),

            // Action Buttons: Upvote, Comment, Donate, Chat
            _buildActionButtons(userId, context),

            const SizedBox(height: 8),

            // Comments Section
            _buildCommentsSection(context),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
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
                // Add delete logic here
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
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
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          snap['description'],
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 6),
        Text(
          'Amount Needed: ${snap['amount']}',
          style: TextStyle(
            fontSize: 16,
            color: AppColor.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'UPI: ${snap['upi']}',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildImageSection(String photoUrl, BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl: photoUrl,
        height: MediaQuery.of(context).size.height * 0.3,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) {
          print('Error loading image: $error'); // Log error
          return Icon(Icons.error);
        },
      ),
    );
  }

  Widget _buildActionButtons(String userId, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () async {
                await PostMethods().updateLike(snap['fundId'], userId, snap['upvote']);
              },
              icon: snap['upvote'].contains(userId)
                  ? const Icon(Icons.favorite, color: Colors.redAccent)
                  : const Icon(Icons.favorite_outline_rounded, color: Colors.red),
            ),
            const SizedBox(width: 4),
            Text(
              '${snap['upvote'].length} Likes',
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
        IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CommentScreen(snap: snap, authController: _authController),
            ),
          ),
          icon: const Icon(Icons.insert_comment_rounded, color: Colors.blueAccent),
        ),
        IconButton(
          onPressed: () {}, // Implement donate logic
          icon: const Icon(Icons.currency_rupee_rounded, color: Colors.greenAccent),
        ),
        IconButton(
          onPressed: () {}, // Implement chat logic
          icon: const Icon(Icons.chat_outlined, color: Colors.orangeAccent),
        ),
      ],
    );
  }

  Widget _buildCommentsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(color: Colors.black87),
              children: [
                TextSpan(text: 'anshu', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' commented: Hey, this is the description of the fund.'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CommentScreen(authController: _authController, snap: snap),
              ),
            ),
            child: const Text(
              'View all 100 comments',
              style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 119, 117, 117)),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${snap['date']}',
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
