import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:quran/screens/auth_screens/sign_up_screen.dart';

import 'sign_in_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFEFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.abc_outlined),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 1.2,
                decoration: BoxDecoration(
                    color: const Color(0xffFEFFFF),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xffD2B7A4).withOpacity(0.5),
                          blurStyle: BlurStyle.normal,
                          blurRadius: 35)
                    ]),
                child: ContainedTabBarView(
                  tabBarProperties: const TabBarProperties(
                      indicatorColor: Color(0xff88B2A8),
                      labelColor: Color(0xff88B2A8),
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      unselectedLabelStyle:
                          TextStyle(fontWeight: FontWeight.normal)),
                  tabs: const [
                    Text(
                      'Sign up',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text('Sign in', style: TextStyle(fontSize: 16)),
                  ],
                  views: const [SignUpScreen(), SignInScreen()],
                )),
            Image.asset(
              'assets/png/auth_img.png',
              width: MediaQuery.of(context).size.width / 2.4,
              height: MediaQuery.of(context).size.height / 2,
            ),
          ],
        ),
      )),
    );
  }
}
