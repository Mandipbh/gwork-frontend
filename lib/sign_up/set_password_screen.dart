import 'package:flutter/material.dart';

class SetPasswordScreen extends StatelessWidget {
  const SetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
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
    );
  }
  
}