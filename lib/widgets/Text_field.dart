import 'package:flutter/material.dart';
import 'package:fundraiser_app/utils/app_colors.dart';

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
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        fillColor: AppColor.primaryBackgroundW,
        hintText: text,
        border: inputborder,
        enabledBorder: inputborder,
        focusedBorder: inputborder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
      keyboardType: inputType,
    );
  }
}
