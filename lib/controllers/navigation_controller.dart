import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt index = 0.obs;
  int get pageIndex => index.value;
  final pageController = PageController();

  void updateIndex(int i) {
    index.value = i;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
