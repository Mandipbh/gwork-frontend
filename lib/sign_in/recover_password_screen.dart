import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/sign_in/code_confirmation_screen.dart';
import 'package:g_worker_app/colors.dart';

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
                      'Phone number',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Text(
                      'Enter your phone number and we will send you an OTP code to reset your account password.',
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CodeConfirmationScreen()),
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
                          'Recover Password'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Icon(Icons.key, color: Colors.white)
                      ],
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
