import 'package:flutter/material.dart';
import 'package:quran/screens/home_screen/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController? emailController = TextEditingController();
    TextEditingController? passController = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xffFEFFFF),
      body: ListView(
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Welcome to Lorem',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 70,
          ),
          const Text(
            'Enter your email address',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              String pattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
            controller: emailController,
            decoration: InputDecoration(
                hintText: 'example@gmail.com',
                hintStyle: const TextStyle(color: Color(0xff808080)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: const Color(0xffF7F7F7)),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Enter your Password',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              String pattern =
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Please enter a valid password';
              }
              return null;
            },
            controller: passController,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.remove_red_eye),
                suffixIconColor: const Color(0xff808080),
                hintText: '********',
                hintStyle: const TextStyle(color: Color(0xff808080)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Color(0xff88B2A8))),
                filled: true,
                fillColor: const Color(0xffF7F7F7)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?",
                      style:
                          TextStyle(color: Color(0xffD2B7A4), fontSize: 14))),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size.fromHeight(53),
                backgroundColor: const Color(0xff88B2A8),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(31))),
            child: const Center(
                child: Text(
              'Sign up',
              style: TextStyle(
                  color: Color(0xffFEFFFF),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
          ),
        ],
      ),
    );
  }
}
