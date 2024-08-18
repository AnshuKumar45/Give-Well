import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text text(String txt, Color c, double size,{FontWeight? fw}) {
  return Text(
    txt,
    style: GoogleFonts.aBeeZee(
      color: c,
      fontSize: size,
      
    ).copyWith(fontWeight: fw),
  );
}
