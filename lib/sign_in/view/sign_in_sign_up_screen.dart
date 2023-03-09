import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';

import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/main.dart';
import 'package:g_worker_app/recover_password/recover_password_screen.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:g_worker_app/sign_up/registration_screen.dart';
import 'package:provider/provider.dart';

import '../../common/common_buttons.dart';
import '../../common/common_input_fields.dart';
import '../../home_page/home_screen.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({super.key});

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInProvider>(
        builder: (BuildContext context, provider, Widget? child) {
      return Scaffold(
        backgroundColor: const Color(0xfff2f2f2),
        body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  tr('welcome'),
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              MyApp.userType != UserType.admin
                  ? singleSelectionButtons(
                      context: context,
                      buttons: [
                        'Sign Up'.toUpperCase(),
                        'Sign In'.toUpperCase()
                      ],
                      selected: provider.getSelected(),
                      onSelectionChange: (value) {
                        provider.setSelected(value);
                      })
                  : Container(),
              const SizedBox(
                height: 30,
              ),
              provider.getSelected() == SelectionType.signUp ? signUpView() : loginView(provider)
            ],
          ),
        ),
        bottomNavigationBar: provider.getSelected() == SelectionType.signUp
            ? Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom > 0
                        ? MediaQuery.of(context).viewInsets.bottom
                        : 16),
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
                  iconAsset: 'logout.png',
                ),
              )
            : Padding(
                padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    submitButton(
                      onButtonTap: () {
                       if(provider.isValidData()){
                         Navigator.pushReplacement(
                           context,
                           MaterialPageRoute(
                               builder: (context) => const HomeScreen()),
                         );
                       }
                      },
                      context: context,
                      backgroundColor: primaryColor,
                      buttonName: 'Sign In',
                      iconAsset: 'logout.png',
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    submitButton(
                      onButtonTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RecoverPasswordScreen()),
                        );
                      },
                      context: context,
                      textColor: primaryColor,
                      iconColor: primaryColor,
                      backgroundColor: Colors.transparent,
                      buttonName: 'Recover Password',
                      iconAsset: 'key.png',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
      );
    });
  }

  Widget signUpView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        phoneNumberTextField(controller: TextEditingController(text: ' ')),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text("Please enter your phone number in order\nto sign up",
              style: Theme.of(context).textTheme.bodyText2),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget loginView(SignInProvider provider) {
    return Column(
      children: [
        phoneNumberTextField(controller: provider.phoneController),
        const SizedBox(height: 20),
        passwordTextField(label: 'Password',controller: provider.passwordController),
        const SizedBox(height: 20),
      ],
    );
  }
}
