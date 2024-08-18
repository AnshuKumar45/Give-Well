import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildInputField({

  required TextEditingController controller,
  required String label,
  IconData? prefixIcon,
  bool readOnly = false,
  int maxLines = 1,
  FocusNode? focusNode,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  void Function()? onTap,
  void Function(String)? onFieldSubmitted,
}) {
  return TextFormField(
    focusNode: focusNode,
    controller: controller,
    readOnly: readOnly,
    maxLines: maxLines,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: GoogleFonts.aBeeZee().copyWith(color: AppColor.grey),
      prefixIcon: Icon(prefixIcon),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColor.primary),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.grey.withOpacity(0.095),
    ),
    validator: validator,
    onTap: onTap,
    onFieldSubmitted: onFieldSubmitted,
    style: GoogleFonts.aBeeZee(),
    autovalidateMode: AutovalidateMode.onUserInteraction,
  );
}
