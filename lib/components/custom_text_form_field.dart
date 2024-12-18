import 'package:flutter/material.dart';

/* custom text for field for reuse */
class CustomTextFormField extends StatelessWidget {
  final String? Function(String?) validator;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String hintText;
  final String text;
  const CustomTextFormField(
      {super.key,
      required this.validator,
      this.obscureText = false,
      required this.controller,
      this.suffixIcon,
      required this.hintText,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text, style: const TextStyle(fontSize: 16)),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          validator: validator,
          obscureText: obscureText,
          obscuringCharacter: '*',
          controller: controller,
          decoration: InputDecoration(
              suffixIcon: suffixIcon,
              suffixIconColor: const Color(0xff808080),
              hintText: hintText,
              hintStyle: const TextStyle(color: Color(0xff808080)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              filled: true,
              fillColor: const Color(0xffF7F7F7)),
        ),
      ],
    );
  }
}
