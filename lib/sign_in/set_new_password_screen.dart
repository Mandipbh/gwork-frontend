import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/home_page/home_screen.dart';
import 'package:g_worker_app/colors.dart';

import '../common/common_buttons.dart';
import '../common/common_input_fields.dart';
import '../common/common_widgets.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        askForExit(context);
        return false;
      },
      child: Scaffold(
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
                      child: Text(
                        'Set Password',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Text('Choose a secure password for your account.',
                        style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 40),
                    passwordTextField(label: 'new password'),
                    const SizedBox(height: 20),
                    passwordTextField(label: 'confirm password'),
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
                              builder: (context) => const HomeScreen()),
                        );
                      },
                      context: context,
                      backgroundColor: primaryColor,
                      buttonName: 'set new Password',
                      iconAsset: 'ic_lock.png',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
