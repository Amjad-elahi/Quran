import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/components/custom_elevated_button.dart';

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog({super.key, required this.msg});
  final String msg;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xffFEFFFF),
      content: SizedBox(
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Lottie.asset("assets/json/error.json", width: 200),
            const Text(
              'Oops, something went wrong!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
            Text(
              msg,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            Column(
              children: [
                CustomElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'Okay',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
