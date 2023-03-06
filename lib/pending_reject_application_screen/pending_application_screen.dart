import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/pending_reject_application_screen/rejected_application_screen.dart';

class PendingApplicationScreen extends StatelessWidget {
  const PendingApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF7F,
      appBar: AppBar(
        backgroundColor: whiteF2F,
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pending application',
          style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              fontFamily: 'Satoshi'),
        ),
      ),
      body: bodyView(context),
    );
  }

  Widget bodyView(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, bottom: 60),
          child: Text(
            'Pending application',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Center(
          child: Image.asset(
            'assets/images/watch-circle.png',
            height: 150,
            width: 150,
          ),
        ),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RejectedApplicationScreen()),
              );
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                child: Column(
                  children: [
                    Text(
                      'Your application has been submitted',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We’ll send you notification when it’s approved',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
