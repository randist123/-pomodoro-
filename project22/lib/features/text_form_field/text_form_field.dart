import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;

  const TextFormFieldWidget({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      maxLines: 3,
    );
  }
}
