import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String textFieldContent;
  final controller;

  CustomTextField({required this.textFieldContent, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: textFieldContent,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
