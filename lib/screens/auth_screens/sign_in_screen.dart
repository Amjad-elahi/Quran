import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:quran/components/custom_elevated_button.dart';
import 'package:quran/components/custom_error_msg.dart';
import 'package:quran/components/custom_text_form_field.dart';
import 'package:quran/screens/auth_screens/cubit/auth_cubit.dart';
import 'package:quran/screens/search_screen/search_screen.dart';

/* sign in screen UI */
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
                      content: Lottie.asset(
                          'assets/json/loading_animation.json',
                          width: 100)));
            }
            if (state is SuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return const SearchScreen();
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
            backgroundColor: Colors.transparent,
            body: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Welcome to Quran Search',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextFormField(
                    text: 'Enter your email address',
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
                    hintText: 'example@gmail.com',
                    suffixIcon: const Icon(Icons.email_rounded),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      bool isPassVisible = false;
                      if (state is PassVisibilityState) {
                        isPassVisible = state.isVisible;
                      }
                      return CustomTextFormField(
                        text: 'Enter your Password',
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
                        obscureText: !isPassVisible,
                        suffixIcon: IconButton(
                          onPressed: () {
                            cubit.passwordVisibility();
                          },
                          icon: Icon(isPassVisible
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded),
                        ),
                        hintText: '********',
                      );
                    },
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
                                  color: Color(0xff9C7E7E), fontSize: 14))),
                    ],
                  ),
                  const SizedBox(
                    height: 105,
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
