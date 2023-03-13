import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/home_page/view/home_screen.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';

import '../../common/common_buttons.dart';
import '../../common/common_input_fields.dart';
import '../../common/common_widgets.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        askForExit(
          context: context,
          onBackPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignInSignUpScreen()),
                (Route<dynamic> route) => false);
          },
          title: tr('admin.exit_dialogue.are_you_sure'),
          description: tr('admin.exit_dialogue.need_to_ask'),
          backButtonName: tr('admin.exit_dialogue.go_back'),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr('admin.sign_in.Recover_password'),
          ),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Text(
                        tr('admin.set_password'),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Text(tr("admin.choose_password"),
                        style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 40),
                    passwordTextField(
                        label: tr('admin.new_password'),
                        controller: TextEditingController()),
                    const SizedBox(height: 20),
                    passwordTextField(
                        label: tr('admin.confirm_new_password'),
                        controller: TextEditingController()),
                    const SizedBox(height: 20),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: submitButton(
                      onButtonTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const HomeScreen(),
                          ),
                          (route) =>
                              false, //if you want to disable back feature set to false
                        );
                      },
                      context: context,
                      backgroundColor: primaryColor,
                      buttonName: tr('admin.set_new_password'),
                      iconAsset: 'lock.png',
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
