import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final bool isPwField;
  final Function(String) getFieldValue;
  // final userName;
  TextEditingController textController = TextEditingController();

  FormTextField(this.getFieldValue,
      {this.isPwField = false, this.textController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: TextField(
        controller: textController,
        obscureText: isPwField,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      onTap: () {
        getFieldValue(textController.text);
      },
    );
  }
}
