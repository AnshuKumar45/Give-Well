import 'package:get/get.dart';

class GlobalLoadingController extends GetxController {
  RxBool isLoading = false.obs;

  void showLoading() {
    isLoading.value = true;
  }

  void hideLoading() {
    isLoading.value = false;
  }
}
