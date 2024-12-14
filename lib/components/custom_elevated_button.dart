import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomElevatedButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(53),
                      backgroundColor: const Color(0xff88B2A8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(31))),
                  child: Center(
                      child: Text(
                    text,
                    style: const TextStyle(
                        color: Color(0xffFEFFFF),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  )),
                );
  }
}