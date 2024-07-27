import 'package:cloud_firestore/cloud_firestore.dart';

class PostMethods {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Future<String> post({
    required String name,
    required String desc,
    required String fundType,
    required String amount,
    required String upi,
    required String endDate,
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
        await _firebaseFirestore.collection('fund').doc(id).set({
          "fundName": name,
          "description": desc,
          "type": fundType,
          "date": DateTime.now(),
          "details": [],
          "endDate": endDate,
          "priority": "medium",
          "url": "",
          "creatorInfo": [],
          "upvote": 0,
        });
        res = "success";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
