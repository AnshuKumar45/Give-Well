import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FundController extends GetxController {
  var funds = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFunds();
  }

  Future<void> fetchFunds() async {
    try {
      isLoading(true);
      hasError(false);
      final querySnapshot = await FirebaseFirestore.instance.collection('fund').get();
      funds.value = querySnapshot.docs.map((doc) {
        var data = doc.data();
        data['fundId'] = doc.id; // Ensure you include the ID for unique identification
        return data;
      }).toList();
    } catch (e) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateLike(String fundId, String userId) async {
    // Locate the specific fund
    var index = funds.indexWhere((element) => element['fundId'] == fundId);
    if (index != -1) {
      var fund = funds[index];
      // Toggle like/unlike
      if (fund['upvote'].contains(userId)) {
        fund['upvote'].remove(userId);
      } else {
        fund['upvote'].add(userId);
      }
      funds[index] = fund; // Trigger UI update

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('fund')
          .doc(fundId)
          .update({'upvote': fund['upvote']});
    }
  }
}
