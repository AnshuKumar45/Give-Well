import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fundraiser_app/models/post_models.dart';

class PostMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<String> post({
    required String name,
    required String desc,
    required String fundType,
    required String amount,
    required String upi,
    required String endDate,
    required String photoUrl,
  }) async {
    String res = "";
    int get = DateTime.now().microsecondsSinceEpoch;
    try {
      if (name.isNotEmpty ||
          desc.isNotEmpty ||
          fundType.isNotEmpty ||
          amount.isNotEmpty ||
          upi.isNotEmpty ||
          endDate.isNotEmpty) {
        String id = fundType + get.toString();
        PostModels postModels = PostModels(
          id: id,
          amount: amount,
          creatorInfo: [],
          date: DateTime.now().toString().substring(0, 11),
          desc: desc,
          details: [],
          endDate: endDate,
          fundType: fundType,
          name: name,
          photoUrl: photoUrl,
          priority: "medium",
          upi: upi,
          upvote: 0,
        );
        await _firebaseFirestore.collection('fund').doc(id).set(
              postModels.toJson(),
            );
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
