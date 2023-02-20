import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_in/otp_exit_popup.dart';
import 'package:g_worker_app/sign_in/set_new_password_screen.dart';

import '../CommonWidgets.dart';

class CodeConfirmationScreen extends StatefulWidget {
  const CodeConfirmationScreen({super.key});

  @override
  State<CodeConfirmationScreen> createState() => _CodeConfirmationScreenState();
}

class _CodeConfirmationScreenState extends State<CodeConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        askForExit(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Recover Password',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Code Confirmation',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                        'Enter below the 4-digit code we just sent to +39 348 613 7727.',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: TextField(
                          style: const TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              floatingLabelBehavior:FloatingLabelBehavior.always,
                              icon: const Icon(Icons.phone_outlined),
                              labelText: 'Phone Number'.toUpperCase(),
                              prefixText: '+39')),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SetNewPasswordScreen()),
                      );
                    },
                    child: SizedBox(
                      height: 60,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Request a new code (00:12)'.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.send_outlined, color: Colors.grey)
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
