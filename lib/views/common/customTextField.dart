import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:library_management_system/constants/constants.dart';

import 'app_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.validator,
    this.controller,
    required this.keyType,
    required this.textSce,
    this.prefixIcon,
    this.focusNode,
  });

  final String label;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType keyType;
  final bool textSce;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    const double? textFieldWidth = kIsWeb ? 600.0 : null;
    return Container(
      width: textFieldWidth,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        style: roundFont(19, lightBlue, FontWeight.w400),
        decoration: InputDecoration(
          errorStyle: roundFont(14, Colors.white, FontWeight.normal),
          labelText: label,
          labelStyle: roundFont(16, lightBlue, FontWeight.normal),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.black,
                width: 1,
                style: BorderStyle.solid), // Custom border color
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: lightBlue), //
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                width: 1, color: Color(darkHeading.value)), // Custom border color
          ),
        ),
        validator: validator,
        keyboardType: keyType,
        obscureText: textSce,
      ),
    );
  }
}
