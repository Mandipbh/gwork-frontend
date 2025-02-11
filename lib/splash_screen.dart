import 'dart:async';

import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/home_page/provider/home_page_provider.dart';
import 'package:g_worker_app/home_page/view/home_screen.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      context.read<HomePageProvider>().getToken().then((value) {
        if (value.isEmpty) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const SignInSignUpScreen()));
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const HomeScreen()));
        }
      });
    });
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: const LinearGradient(
                      colors: [splashColor1, splashColor2])),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/images/logo.png'),
                  ),
                  RichText(
                      text: const TextSpan(
                          text: 'g',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(
                          text: '.',
                          style: TextStyle(
                              color: Color(0xff4eab54),
                              fontSize: 36,
                              fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: 'work',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w500),
                        )
                      ]))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Powered by',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: const Color(0xff7B8794))),
                Text('Mokka Studios',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .apply(color: const Color(0xff26AB53))),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
