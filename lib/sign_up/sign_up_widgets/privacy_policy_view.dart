import 'package:flutter/material.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Text("Amet minim mollit non",
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 16),
          Text("Amet minim mollit non",
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headline5),
          const SizedBox(height: 16),
          Text("Amet minim mollit non",
              style: Theme.of(context).textTheme.headline4),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }
}
