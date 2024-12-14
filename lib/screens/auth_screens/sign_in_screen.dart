import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/components/custom_elevated_button.dart';
import 'package:quran/components/custom_error_msg.dart';
import 'package:quran/screens/auth_screens/cubit/auth_cubit.dart';
import 'package:quran/screens/home_screen/home_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<AuthCubit>();
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoadingState) {
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                      backgroundColor: Colors.transparent,
                      content: Lottie.asset('assets/json/loading_animation.json',
                          width: 100)));
            }
            if (state is SuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            }
            if (state is ErrorState) {
              Navigator.pop(context);
              showDialog(
                  context: context,
                  builder: (context) {
                    return CustomErrorDialog(msg: (state.msg));
                  });
            }
          },
          child: Scaffold(
            backgroundColor: const Color(0xffFEFFFF),
            body: Form(
              key: cubit.formKey,
              child: ListView(
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
                    controller: cubit.signInEmailController,
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
                  const Text('Enter your Password',
                      style: TextStyle(fontSize: 16)),
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
                    controller: cubit.signInPassController,
                    decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.remove_red_eye),
                        suffixIconColor: const Color(0xff808080),
                        hintText: '********',
                        hintStyle: const TextStyle(color: Color(0xff808080)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Color(0xff88B2A8))),
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
                              style: TextStyle(
                                  color: Color(0xffD2B7A4), fontSize: 14))),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.signIn();
                      }
                    },
                    text: 'Sign in',
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
