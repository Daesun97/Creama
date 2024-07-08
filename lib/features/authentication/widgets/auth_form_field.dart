import 'package:creama/utils/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final String? Function(String? value)? validator;
  final void Function(String? value)? onSaved;

  const AuthFormField(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      this.validator,
      this.onSaved});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.all(
          Sizes.size12,
        ),
        filled: true,
        hintText: hintText,
        hintStyle:
            TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }
}
