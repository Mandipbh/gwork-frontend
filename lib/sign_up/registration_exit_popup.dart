import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_in/sign_in_sign_up_screen.dart';

class RegistrationExitPopup extends StatelessWidget {
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
          'Are you sure you want to stop registration?',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Text('All the saved data will be deleted'),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: primaryColor),
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Stay Here'.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(Icons.arrow_circle_down_outlined,
                    color: Colors.white)
              ],
            )),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignInSignUpScreen()),
                (Route<dynamic> route) => false);
          },
          child: Container(
            height: 60,
            child: Center(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Go Back'.toUpperCase(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                      fontSize: 18),
                ),
                const SizedBox(
                  width: 8,
                ),
                const Icon(Icons.subdirectory_arrow_left_outlined,
                    color: Colors.red)
              ],
            )),
          ),
        )
      ],
    );
  }
}
