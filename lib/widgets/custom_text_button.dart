import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color textColor;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.label,
    this.fontSize = 18,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          color: onPressed != null ? textColor : textColor.withOpacity(0.5),
        ),
      ),
    );
  }
}
