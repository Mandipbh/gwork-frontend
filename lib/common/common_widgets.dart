import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';

void askForExit({
  required BuildContext context,
  required Function onBackPressed,
  required String title,
  required String description,
  String backButtonName = 'Go Back',
}) {
  showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
          contentPadding: const EdgeInsets.all(12),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.red[100],
                child: const Center(
                  child: Icon(
                    Icons.warning_amber_outlined,
                    size: 36,
                    color: Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Text(description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2),
              ),
              const SizedBox(
                height: 20,
              ),
              submitButton(
                onButtonTap: () {
                  Navigator.pop(context);
                },
                context: context,
                backgroundColor: primaryColor,
                buttonName: 'Stay Here',
                iconAsset: 'arrow_circle_down.png',
              ),
              const SizedBox(
                height: 10,
              ),
              submitButton(
                  onButtonTap: () {
                    onBackPressed();
                  },
                  context: context,
                  backgroundColor: Colors.transparent,
                  buttonName: backButtonName,
                  textColor: Colors.red,
                  iconAsset: 'go_backward.png',
                  iconColor: Colors.red),
            ],
          )));
}
