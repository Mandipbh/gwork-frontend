import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/sign_in/set_new_password_screen.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

import '../CommonWidgets.dart';

class CodeConfirmationScreen extends StatefulWidget {
  const CodeConfirmationScreen({super.key});

  @override
  State<CodeConfirmationScreen> createState() => _CodeConfirmationScreenState();
}

class _CodeConfirmationScreenState extends State<CodeConfirmationScreen> {
  int secondsRemaining = 30;
  bool enableResend = false;
  late Timer timer;
  String otp = '9898';

  @override
  initState() {
    super.initState();
    startTimer();
  }

  startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      print('secondsRemaining :: $secondsRemaining');
      if (secondsRemaining != 0) {
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
    return WillPopScope(
      onWillPop: () async {
        askForExit(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Recover Password',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
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
                    const Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Code Confirmation',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                        'Enter below the 4-digit code we just sent to +39 348 613 7727.',
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 20),
                    OTPTextField(
                        // controller: otpController,
                        length: 4,
                        width: MediaQuery.of(context).size.width,
                        textFieldAlignment: MainAxisAlignment.spaceAround,
                        fieldWidth: MediaQuery.of(context).size.width/5,
                        otpFieldStyle: OtpFieldStyle(
                            backgroundColor: Colors.white,
                            enabledBorderColor: Colors.white,
                            focusBorderColor: Colors.white),
                        fieldStyle: FieldStyle.box,
                        outlineBorderRadius: 12,
                        style: const TextStyle(fontSize: 40),
                        onChanged: (pin) {},
                        onCompleted: (pin) {
                          print("Completed: " + pin);
                          if(pin == otp){
                            timer.cancel();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SetNewPasswordScreen()),
                            );
                          }
                        })
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: InkWell(
                    splashColor: Colors.white,
                    onTap: enableResend ? resendOTP : null,
                    child: SizedBox(
                      height: 60,
                      child: Center(
                          child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          enableResend ? Text(
                            'Request a new code'
                                .toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18),
                          ) : Text(
                            'Request a new code (00:${secondsRemaining.toString().padLeft(2,'0')})'
                                .toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  Colors.grey,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(Icons.send_outlined, color: enableResend ? Colors.black : Colors.grey)
                        ],
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resendOTP() {
    print('resendOTP');
    setState(() {
      enableResend = false;
      secondsRemaining = 30;
    });
    startTimer();
  }
}
