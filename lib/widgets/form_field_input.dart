import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormField {
  InputDecoration inputDecoration(String text, bool isFilled,Icon icon) {
    final inputborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return InputDecoration(
      labelText: text,
      labelStyle: GoogleFonts.aBeeZee(),
      border: inputborder,
      contentPadding: const EdgeInsets.all(8),
      filled: isFilled,
      prefixIcon: icon,
    );
  }
  InputDecoration inputDecorationNormal(String text, bool isFilled) {
    final inputborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return InputDecoration(
      labelText: text,
      labelStyle: GoogleFonts.aBeeZee(),
      border: inputborder,
      contentPadding: const EdgeInsets.all(8),
      filled: isFilled,
    );
  }
}
