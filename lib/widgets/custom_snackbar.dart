import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar({
  required String title,
  required String message,
  SnackPosition position = SnackPosition.TOP,
  Color backgroundColor = Colors.transparent,
  Color textColor = Colors.black,
  Duration duration = const Duration(seconds: 3),
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: position,
    backgroundColor: backgroundColor,
    colorText: textColor,
    duration: duration,
  );
}
