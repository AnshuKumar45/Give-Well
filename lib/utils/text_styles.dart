import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text text(String text, Color c, double size) {
  return Text(
    text,
    style: GoogleFonts.aBeeZee(
      color: c,
      fontSize: size,
    ),
  );
}
