import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onTap;
  final String innerText;
  final bool loading;
  final Color textColor;
  final double borderRadius;
  final Color buttonColor;
  final Color borderColor;
  final EdgeInsetsGeometry padding;
  final Color loadingIndicatorColor;
  final double width;

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.innerText,
    this.loading = false,
    this.textColor = Colors.white,
    this.borderRadius = 12.0,
    this.buttonColor = Colors.purpleAccent,
    this.borderColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
    this.loadingIndicatorColor = Colors.white,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
                color: borderColor, width: 1), // Border color and width
          ),
          padding: padding,
        ),
        child: loading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(loadingIndicatorColor),
                ),
              )
            : Text(
                innerText,
                style: GoogleFonts.aBeeZee()
                    .copyWith(color: textColor, fontSize: 20),
              ),
      ),
    );
  }
}
