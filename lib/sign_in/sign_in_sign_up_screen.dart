import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_in/recover_password_screen.dart';
import 'package:g_worker_app/sign_up/registration_screen.dart';

import '../common/common_buttons.dart';
import '../common/common_input_fields.dart';
import '../home_page/home_screen.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({super.key});

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  bool isSignUp = false;
  var phoneController = TextEditingController();

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
              phoneNumberTextField(),
              const SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(right: 40),
                child: Text(
                    "Please enter your phone number in order\nto sign up",
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              const SizedBox(height: 20),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: submitButton(
              onButtonTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistrationScreen()),
                );
              },
              context: context,
              backgroundColor: primaryColor,
              buttonName: 'Sign Up',
              iconAsset: 'ic_logout.png',
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
              phoneNumberTextField(),
              const SizedBox(height: 20),
              passwordTextField(label: 'Password'),
              const SizedBox(height: 20),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                submitButton(
                  onButtonTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  context: context,
                  backgroundColor: primaryColor,
                  buttonName: 'Sign In',
                  iconAsset: 'ic_logout.png',
                ),
                const SizedBox(
                  height: 16,
                ),
                submitButton(
                  onButtonTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecoverPasswordScreen()),
                    );
                  },
                  context: context,
                  textColor: primaryColor,
                  backgroundColor: Colors.white,
                  buttonName: 'Recover Password',
                  iconAsset: 'ic_key.png',
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
