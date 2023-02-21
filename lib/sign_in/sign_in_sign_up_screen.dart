import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_in/recover_password_screen.dart';
import 'package:g_worker_app/sign_up/registration_screen.dart';

import '../home_page/home_screen.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({super.key});

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Welcome!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white),
                padding: const EdgeInsets.all(4),
                child: Row(children: [
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: isSignUp ? primaryColor : Colors.white),
                        child: Center(
                            child: Text(
                          'SIGN UP',
                          style: Theme.of(context).textTheme.subtitle1!.apply(
                              color: isSignUp ? Colors.white : primaryColor),
                        ))),
                  )),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      setState(() {
                        isSignUp = !isSignUp;
                      });
                    },
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: !isSignUp ? primaryColor : Colors.white),
                        child: Center(
                          child: Text('SIGN IN',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .apply(
                                      color: !isSignUp
                                          ? Colors.white
                                          : primaryColor)),
                        )),
                  ))
                ]),
              ),
              const SizedBox(
                height: 30,
              ),
              isSignUp ? signUpView() : loginView()
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        icon: const Icon(Icons.phone_outlined),
                        labelText: 'Phone Number'.toUpperCase(),
                        prefixText: '+39')),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                    "Please enter your phone number in order to sign up",
                    style: TextStyle(fontSize: 16)),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationScreen()),
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryColor),
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Sign Up'.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Icon(Icons.logout, color: Colors.white)
                  ],
                )),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginView() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                    style: const TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        icon: const Icon(Icons.phone_outlined),
                        labelText: 'Phone Number'.toUpperCase(),
                        prefixText: '+39')),
              ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: TextField(
                    obscureText: true,
                    obscuringCharacter: '*',
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: const Icon(Icons.remove_red_eye_outlined),
                        icon: const Icon(Icons.lock_outline),
                        labelText: 'Password'.toUpperCase())),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                GestureDetector(
                  onTap:(){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor),
                    child: Center(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Sign In'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(Icons.logout, color: Colors.white)
                      ],
                    )),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecoverPasswordScreen()),
                    );
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white),
                    child: Center(
                        child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Recover Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18)),
                        SizedBox(
                          width: 8,
                        ),
                        Icon(Icons.key)
                      ],
                    )),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
