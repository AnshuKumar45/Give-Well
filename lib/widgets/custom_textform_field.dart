import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;
  final TextInputType inputType;
  const TextInput(
      {super.key,
      required this.textEditingController,
      required this.text,
      required this.inputType});
  @override
  Widget build(BuildContext context) {
    final inputborder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: Divider.createBorderSide(context),
    );
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: text,
        border: inputborder,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: inputType,
    );
  }
}
