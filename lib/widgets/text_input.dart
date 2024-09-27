import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged? onChanged;
  final String? labelText;
  final TextInputType? inputType;

  const CustomTextInput(
      {Key? key,
      this.controller,
      this.onChanged,
      this.labelText,
      this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
          labelText: labelText, border: const OutlineInputBorder()),
      onChanged: onChanged,
    );
  }
}
