import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/home_page/view/home_screen.dart';

class RejectedApplicationScreen extends StatelessWidget {
  const RejectedApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF7F,
      appBar: AppBar(
        backgroundColor: whiteF2F,
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
        title: Text(
          tr('Professional.logIn.Application_rejected.Application_rejected'),
          style: const TextStyle(
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16),
          child: Text(
            tr('Professional.logIn.Application_rejected.Application_rejected'),
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/rejected_application.png',
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
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
                        tr('Professional.logIn.Application_rejected.Your_application_has_been_declined'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tr('Professional.logIn.Application_rejected.We_can_not_allow_you_to_enter_the_platform_based_on_your_data'),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 18),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: white,
              boxShadow: [
                BoxShadow(
                  color: green0D3.withOpacity(0.2),
                  offset: const Offset(0, -5),
                  blurRadius: 42,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('Professional.logIn.Application_rejected.reapply')
                            .toUpperCase(),
                        style: const TextStyle(
                            color: white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Satoshi'),
                      ),
                      const SizedBox(width: 8),
                      Image.asset('assets/images/refresh.png',
                          height: 24, width: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
