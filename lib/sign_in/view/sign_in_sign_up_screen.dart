import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:g_worker_app/Constants.dart';

import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/main.dart';
import 'package:g_worker_app/my_profile/my_profile_widgets/my_profile_screen.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/recover_password_screen.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:g_worker_app/sign_up/registration_screen.dart';
import 'package:provider/provider.dart';

import '../../common/common_buttons.dart';
import '../../common/common_input_fields.dart';
import '../../home_page/view/home_screen.dart';

class SignInSignUpScreen extends StatefulWidget {
  const SignInSignUpScreen({super.key});

  @override
  State<SignInSignUpScreen> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<SignInProvider, SignUpProvider>(builder:
        (BuildContext context, provider, signUpProvider, Widget? child) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: whiteF2F,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Text(
                      tr('admin.sign_in.Welcome'),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    MyApp.apkType == UserType.admin
                        ? Text(
                            tr('admin.sign_in.enter_your_phone_no_sign_in'),
                            style: const TextStyle(
                                color: black343,
                                fontFamily: 'Manrope',
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          )
                        : Container(),
                    MyApp.apkType != UserType.admin
                        ? singleSelectionButtons(
                            context: context,
                            buttons: [
                              tr('admin.sign_in.Sign_Up').toUpperCase(),
                              tr('admin.sign_in.Sign_In').toUpperCase()
                            ],
                            selected: provider.getSelected(),
                            onSelectionChange: (value) {
                              provider.setSelected(value);
                            })
                        : Container(),
                    const SizedBox(
                      height: 30,
                    ),
                    provider.getSelected() == SelectionType.signUp
                        ? signUpView(signUpProvider)
                        : loginView(provider)
                  ],
                ),
              ),
            ),
            bottomNavigationBar: provider.getSelected() == SelectionType.signUp
                ? Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: MediaQuery.of(context).viewInsets.bottom > 0
                            ? MediaQuery.of(context).viewInsets.bottom
                            : 16),
                    child: submitButton(
                      onButtonTap: () {
                        signUpProvider.checkPhoneNo(context);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      context: context,
                      backgroundColor: primaryColor,
                      buttonName: tr('admin.sign_in.Sign_Up'),
                      iconAsset: 'logout.png',
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        top: 8,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        submitButton(
                          onButtonTap: () {
                            if (provider.isValidData()) {
                              provider.getLoginResponseStream().listen((event) {
                                if (event.success) {
                                  signUpProvider.updateUserType(event.role!);
                                  provider.clearSignIn();
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                  );
                                }
                              });
                              if (MyApp.apkType == UserType.admin) {
                                provider.adminLogin();
                              } else {
                                provider.login(context);
                              }
                            }
                          },
                          context: context,
                          backgroundColor: primaryColor,
                          buttonName: tr('admin.sign_in.Sign_In'),
                          iconAsset: 'logout.png',
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        submitButton(
                          onButtonTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RecoverPasswordScreen()),
                            );
                          },
                          context: context,
                          textColor: primaryColor,
                          iconColor: primaryColor,
                          backgroundColor: Colors.transparent,
                          buttonName: tr('admin.sign_in.Recover_password'),
                          iconAsset: 'key.png',
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
          ),
          Positioned.fill(
              child: Center(
                  child:
                      provider.getIsLogging() || signUpProvider.getIsLogging()
                          ? const CircularProgressIndicator()
                          : const SizedBox(
                              height: 0,
                            )))
        ],
      );
    });
  }

  Widget signUpView(SignUpProvider signUpProvider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        phoneNumberTextField(
          controller: signUpProvider.phoneController,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(right: 40),
          child: Text(tr('admin.sign_in.enter_your_phone_no_sign_up'),
              style: Theme.of(context).textTheme.bodyText2),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget loginView(SignInProvider provider) {
    return Column(
      children: [
        phoneNumberTextField(controller: provider.phoneController),
        const SizedBox(height: 20),
        passwordTextField(
            label: tr('admin.sign_in.password'),
            controller: provider.passwordController),
        const SizedBox(height: 20),
      ],
    );
  }
}
