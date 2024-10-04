import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomCircularProgress extends StatelessWidget {
  final bool isDarkMode;

  const CustomCircularProgress({super.key, this.isDarkMode = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: isDarkMode
              ? AppColor.primaryBackgroundB
              : AppColor.primaryBackgroundW,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12.0),
        child: CircularProgressIndicator(
          strokeWidth: 5.0,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.primary),
          backgroundColor: Colors
              .transparent, // Transparent background to blend with container
        ),
      ),
    );
  }
}
