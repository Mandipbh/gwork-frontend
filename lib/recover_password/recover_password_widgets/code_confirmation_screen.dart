import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/common/common_widgets.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/set_new_password_screen.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:g_worker_app/sign_up/registration_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';

class CodeConfirmationScreen extends StatefulWidget {
  String? phoneNumber;
  final bool? isRegister;
  CodeConfirmationScreen({super.key, this.phoneNumber, this.isRegister});

  @override
  State<CodeConfirmationScreen> createState() => _CodeConfirmationScreenState();
}

class _CodeConfirmationScreenState extends State<CodeConfirmationScreen> {
  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;
  String otp = '';

  @override
  initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (secondsRemaining > 1) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        timer.cancel();
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
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
    }, child: Consumer<SignUpProvider>(
      builder: (context, signUpProvider, child) {
        return Stack(
          children: [
            Scaffold(
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
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                              tr('admin.sign_in.Code_confirmation'),
                              style: Theme.of(context).textTheme.headline1,
                            ),
                          ),
                          Text(
                              "${tr('admin.sign_in.enter_digit')} ${widget.phoneNumber}",
                              style: Theme.of(context).textTheme.bodyText2),
                          const SizedBox(height: 20),
                          OTPTextField(
                              // controller: otpController,
                              length: 4,
                              width: MediaQuery.of(context).size.width,
                              textFieldAlignment: MainAxisAlignment.spaceAround,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 6),
                              fieldWidth: MediaQuery.of(context).size.width / 5,
                              otpFieldStyle: OtpFieldStyle(
                                  backgroundColor: Colors.white,
                                  enabledBorderColor: Colors.white,
                                  focusBorderColor: const Color(0xffD3DCD7)),
                              fieldStyle: FieldStyle.box,
                              outlineBorderRadius: 12,
                              style: Theme.of(context).textTheme.headline2!,
                              onChanged: (pin) {},
                              onCompleted: (pin) {
                                if (widget.isRegister!) {
                                  ApiClient()
                                      .verifyOtp(widget.phoneNumber.toString(),
                                          pin, context)
                                      .then((checkVerifyOtp) {
                                    if (checkVerifyOtp.success!) {
                                      ProgressLoader(
                                          context, "OTP Verify SuccessFully");
                                      timer.cancel();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegistrationScreen()),
                                      );
                                    }
                                  });
                                } else {
                                  ApiClient()
                                      .otpVerify(widget.phoneNumber.toString(),
                                          pin, context)
                                      .then((otpVerify) {
                                    if (otpVerify.success!) {
                                      ProgressLoader(
                                          context, "OTP Verify SuccessFully");
                                      timer.cancel();
                                      print("TOKEN CC :: ${otpVerify.token}");
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              SetNewPasswordScreen(
                                            token: otpVerify.token,
                                          ),
                                        ),
                                      );
                                    }
                                  });
                                }
                              }),
                          const SizedBox(height: 20),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: submitButton(
                          onButtonTap: () {
                            if (enableResend) {
                              resendOTP();
                            }
                          },
                          context: context,
                          backgroundColor: Colors.transparent,
                          textColor: enableResend ? Colors.black : Colors.grey,
                          buttonName: enableResend
                              ? tr('admin.sign_in.Request_new_code')
                              : 'Request a new code (00:${secondsRemaining.toString().padLeft(2, '0')})',
                          iconAsset: 'otp_send.png',
                          iconColor: enableResend ? Colors.black : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
                child: Center(
                    child: signUpProvider.getIsLogging()
                        ? const CircularProgressIndicator()
                        : const SizedBox(
                            height: 0,
                          )))
          ],
        );
      },
    ));
  }

  void resendOTP() {
    setState(() {
      enableResend = false;
      secondsRemaining = 60;
    });
    startTimer();
    ApiClient().getOtp(widget.phoneNumber.toString(), context);
  }
}
