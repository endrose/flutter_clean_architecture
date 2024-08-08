import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObsecure;
  final TextEditingController controller;

  const AuthField({
    super.key,
    required this.hintText,
    this.isObsecure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      obscureText: isObsecure,
      validator: (value) {
        // if (value!.isEmpty) {
        //   return '$hintText is required';
        // }
        return value;
      },
    );
  }
}
