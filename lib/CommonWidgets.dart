import 'package:flutter/material.dart';
import 'package:g_worker_app/sign_in/otp_exit_popup.dart';
import 'package:g_worker_app/sign_up/registration_exit_popup.dart';

void askForExit(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: OTPExitPopup()));
}

void askForStopRegistration(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: RegistrationExitPopup()));
}