import 'package:flutter/material.dart';

import 'package:g_worker_app/home_page/home_screen.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/payment_info_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/personal_info_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/privacy_policy_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/select_service_view.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/set_password_view.dart';

import '../colors.dart';
import '../common/common_buttons.dart';
import '../common/common_widgets.dart';
import '../custom_progress_bar.dart';
import '../sign_in/sign_in_sign_up_screen.dart';

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
        askForExit(context: context,onBackPressed: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => const SignInSignUpScreen()),
                  (Route<dynamic> route) => false);
        }, title: '', description: '');
        return false;
      },
      child: Scaffold(
          backgroundColor: const Color(0xfff2f2f2),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.13),
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
                          askForExit(context: context,onBackPressed: (){
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInSignUpScreen()),
                                    (Route<dynamic> route) => false);
                          }, title: '', description: '');
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
      const SelectServiceView(),
      const SetPasswordView(),
      const PersonalInfoView(),
      const PaymentInfoView(),
      const ProfilePictureView(),
      const PrivacyPolicyView()
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
    String label = currentPage == 1
        ? 'Reason'
        : currentPage == 2
            ? 'Password'
            : currentPage == 3
                ? 'Personal Info'
                : currentPage == 4
                    ? 'Payment Method'
                    : currentPage == 5
                        ? 'Profile Picture'
                        : '';
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
                      Text(label.toUpperCase()),
                      const SizedBox(width: 30),
                      Expanded(
                          child: CustomProgressBar(
                        max: 5,
                        current: currentPage.toDouble(),
                        color: primaryColor,
                        bgColor: whiteF2F,
                      )),
                    ],
                  ),
                ),
          previousAndNextButtons(
              context: context,
              onPreviousTap: () {
                controller.previousPage(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              onNextTap: () {
                if (currentPage > 5) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                } else {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeIn);
                }
              },
              nextButtonName: currentPage > 5 ? 'Accept' : 'Next Step',
              nextButtonIcon: Icon(
                  currentPage > 5 ? Icons.done : Icons.arrow_forward,
                  color: Colors.white),
              showPrevious: currentPage != 1 && currentPage <= 5),
        ],
      ),
    );
  }
}
