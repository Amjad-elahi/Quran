import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:quran/screens/auth_screens/sign_up_screen.dart';
import 'sign_in_screen.dart';

/* auth screen UI */
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xffEEDCDF),
          Color(0xffDFDFE1),
          Color(0xffE9DFE1),
          Color(0xffD4DBDD),
          Color(0xffD8D9DB)
        ], begin: Alignment.topLeft),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          leading: Image.asset(
            'assets/png/Quran_logo.png',
          ),
          leadingWidth: 150,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: ContainedTabBarView(
                          tabBarProperties: const TabBarProperties(
                              indicatorColor: Color(0xff796181),
                              labelColor: Color(0xff796181),
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
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
                    Expanded(
                      child: Image.asset(
                        'assets/png/auth_image.png',
                        width: MediaQuery.of(context).size.width / 2.4,
                        height: MediaQuery.of(context).size.height / 2,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: [
                    Image.asset(
                      'assets/png/auth_image.png',
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 1.5,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: ContainedTabBarView(
                          tabBarProperties: const TabBarProperties(
                              indicatorColor: Color(0xff796181),
                              labelColor: Color(0xff796181),
                              labelStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
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
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
