import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_input_fields.dart';

import 'package:g_worker_app/sign_in/code_confirmation_screen.dart';
import 'package:g_worker_app/colors.dart';

import '../common/common_buttons.dart';

class RecoverPasswordScreen extends StatefulWidget {
  const RecoverPasswordScreen({super.key});

  @override
  State<RecoverPasswordScreen> createState() => _RecoverPasswordScreenState();
}

class _RecoverPasswordScreenState extends State<RecoverPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recover Password',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text('Phone number',
                        style: Theme.of(context).textTheme.headline1),
                  ),
                  Text(
                      'Enter your phone number and we will send you an OTP code to reset your account password.',
                      style: Theme.of(context).textTheme.bodyText2),
                  const SizedBox(height: 40),
                  phoneNumberTextField(),
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
                          builder: (context) => const CodeConfirmationScreen()),
                    );
                  },
                  context: context,
                  backgroundColor: primaryColor,
                  buttonName: 'Recover Password',
                  iconAsset: 'key.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
