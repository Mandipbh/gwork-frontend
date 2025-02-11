import 'package:easy_localization/easy_localization.dart';
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
              tr('Professional.logIn.PrivacyPolicy.Privacy_Policy'),
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
          Text("Amet minim mollit non",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text("Amet minim mollit non",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Text("Amet minim mollit non",
              style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          Text(
              "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
              style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
