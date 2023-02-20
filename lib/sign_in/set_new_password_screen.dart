import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/CommonWidgets.dart';
import 'package:g_worker_app/home_screen.dart';
import 'package:g_worker_app/sign_in/code_confirmation_screen.dart';
import 'package:g_worker_app/colors.dart';

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
                        'Set Password',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text('Choose a secure password for your account.',
                        style: TextStyle(fontSize: 16)),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon:
                                  const Icon(Icons.remove_red_eye_outlined),
                              icon: const Icon(Icons.lock_outline),
                              labelText: 'New Password'.toUpperCase())),
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon:
                                  const Icon(Icons.remove_red_eye_outlined),
                              icon: const Icon(Icons.lock_outline),
                              labelText: 'Confirm New Password'.toUpperCase())),
                    ),
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
                            builder: (context) =>
                                const HomeScreen()),
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
                            'set new Password'.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(Icons.lock, color: Colors.white)
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
