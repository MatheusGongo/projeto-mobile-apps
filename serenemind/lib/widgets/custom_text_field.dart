import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    required this.labelText,
    this.obscureText = false,
    required this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(labelText: labelText),
      onSaved: onSaved,
      validator: validator,
    );
  }
}
