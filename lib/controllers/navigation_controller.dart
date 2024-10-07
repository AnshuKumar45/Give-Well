import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NavigationController extends GetxController {
  final box = GetStorage(); // Create an instance of GetStorage
  RxInt index = 0.obs;

  int get pageIndex => index.value;

  final pageController = PageController();

  @override
  void onInit() {
    super.onInit();
    // Load the saved index from GetStorage
    int savedIndex = box.read('pageIndex') ?? 0;
    index.value = savedIndex; // Just load the index without jumping
  }

  void updateIndex(int i) {
    index.value = i;
    box.write('pageIndex', i); // Save the current index to GetStorage
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
