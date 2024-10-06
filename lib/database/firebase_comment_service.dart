import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fundraiser_app/models/comment_model.dart';

class CommentMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> post({
    required String userName,
    required String text,
    required String publishDate,
    required String profilePic,
    required String fundId,
    required String userId,
  }) async {
    String res = "";
    int get = DateTime.now().microsecondsSinceEpoch;
    try {
      if (text.isNotEmpty || publishDate.isNotEmpty) {
        String commentId = userName + get.toString();
        CommentModels comment = CommentModels(
            commentId: commentId,
            datePublished: publishDate,
            likes: [],
            name: userName,
            profile: profilePic,
            text: text,
            userId: userId);
        await _firebaseFirestore
            .collection('fund')
            .doc(fundId)
            .collection('comments')
            .doc(commentId)
            .set(
              comment.toJson(),
            );
      }
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
