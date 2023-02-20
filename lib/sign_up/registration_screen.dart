import 'package:flutter/material.dart';
import 'package:g_worker_app/CommonWidgets.dart';
import 'package:g_worker_app/home_screen.dart';
import 'package:g_worker_app/sign_up/payment_info_screen.dart';
import 'package:g_worker_app/sign_up/personal_info_screen.dart';
import 'package:g_worker_app/sign_up/privacy_policy_screen.dart';
import 'package:g_worker_app/sign_up/profile_picture_screen.dart';
import 'package:g_worker_app/sign_up/select_service_screen.dart';
import 'package:g_worker_app/sign_up/set_password_screen.dart';

import '../colors.dart';
import '../custom_progress_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool provideSelected = false;
  PageController controller = PageController();
  int currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        askForStopRegistration(context);
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
            child: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              flexibleSpace: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      const Text(
                        'Onboarding',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          askForStopRegistration(context);
                        },
                      )
                    ],
                  ),
                ],
              ),
              backgroundColor: const Color(0xfff2f2f2),
              elevation: 1,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: mainView(),
          )),
    );
  }

  Widget mainView() {
    final List<Widget> pages = <Widget>[
      const SelectServiceScreen(),
      const SetPasswordScreen(),
      const PersonalInfoScreen(),
      const PaymentInfoScreen(),
      const ProfilePictureScreen(),
      const PrivacyPolicyScreen()
    ];
    return Column(
      children: [
        Expanded(
          child: PageView(
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            controller: controller,
            onPageChanged: (int pageIndex) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                setState(() {
                  currentPage = pageIndex + 1;
                });
              });
            },
            children: pages,
          ),
        ),
        progressView()
      ],
    );
  }

  Widget progressView() {
    return Container(
      height: currentPage > 5 ? 78 : 128,
      // margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          currentPage > 5
              ? Container()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: const Color(0xfff2f2f2),
                        child: Text(
                          currentPage.toString().padLeft(2, '0'),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text('Reason'.toUpperCase()),
                      const SizedBox(width: 30),
                      Expanded(
                          child: CustomProgressBar(
                        max: 5,
                        current: currentPage.toDouble(),
                        color: primaryColor,
                      )),
                    ],
                  ),
                ),
          currentPage == 1 || currentPage > 5
              ? GestureDetector(
                  onTap: () {
                    if (currentPage > 5) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const HomeScreen()),
                      );
                    } else {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    }
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
                          currentPage > 5
                              ? 'Accept'.toUpperCase()
                              : 'Next Step'.toUpperCase(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                            currentPage > 5
                                ? Icons.done
                                : Icons.arrow_forward,
                            color: Colors.white)
                      ],
                    )),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        child: SizedBox(
                          height: 60,
                          child: Center(
                              child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.arrow_back,
                                  color: Colors.black),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Previous Step'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ],
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          controller.nextPage(
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.easeIn);
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
                                'Next Step'.toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 18),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(Icons.arrow_forward,
                                  color: Colors.white)
                            ],
                          )),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
