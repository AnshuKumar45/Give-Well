import 'package:flutter/material.dart';

Text text(String text, Color c, double size) {
  return Text(
    text,
    style: TextStyle(
      color: c,
      fontSize: size,
    ),
  );
}
