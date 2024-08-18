import 'package:flutter/material.dart';
void fieldFocusChange({
  required BuildContext context, 
  required FocusNode currentFocus, 
  required FocusNode nextFocus
}) {
  currentFocus.unfocus(); // Unfocus the current field
  FocusScope.of(context).requestFocus(nextFocus); // Request focus on the next field
}
