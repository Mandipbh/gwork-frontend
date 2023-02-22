import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/sign_in/sign_in_sign_up_screen.dart';

class OTPExitPopup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.red[100],
          child: const Center(
            child: Icon(
              Icons.warning_amber_outlined,
              size: 36,
              color: Colors.red,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Are you sure you want to go back',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text('you will need to ask for another OTP'),
        ),
        const SizedBox(
          height: 20,
        ),
        submitButton(
          onButtonTap: () {
            Navigator.pop(context);
          },
          context: context,
          backgroundColor: primaryColor,
          buttonName: 'Stay Here',
          iconAsset: 'arrow_circle_down.png',
        ),
        const SizedBox(
          height: 10,
        ),
        submitButton(
            onButtonTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SignInSignUpScreen()),
                  (Route<dynamic> route) => false);
            },
            context: context,
            backgroundColor: Colors.transparent,
            buttonName: 'Go Back',
            textColor: Colors.red,
            iconAsset: 'go_backward.png',
            iconColor: Colors.red),
      ],
    );
  }
}
