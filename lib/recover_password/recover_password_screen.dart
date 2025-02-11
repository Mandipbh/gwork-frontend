import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_input_fields.dart';

import 'package:g_worker_app/recover_password/code_confirmation_screen.dart';
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
        title: Text(
          tr('admin.sign_in.Recover_password'),
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
                    child: Text(tr('admin.sign_in.phone_number'),
                        style: Theme.of(context).textTheme.displayLarge),
                  ),
                  Text(tr('admin.sign_in.recover_password_enter_phone_no'),
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 40),
                  phoneNumberTextField(
                      controller: TextEditingController(text: ' ')),
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
                  buttonName: tr('admin.sign_in.Recover_password'),
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
