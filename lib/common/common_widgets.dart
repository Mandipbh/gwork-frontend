import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/my_profile/my_profile_widgets/edit_profile_picture_dialogue_client.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/edit_profile_picture_dialogue.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/upload_profile_picture_dialogue.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/edit_document_dialogue.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/upload_document_dialogue.dart';

void base64EncodeFile(List<dynamic> args) {
  final SendPort sendPort = args[0] as SendPort;
  final File file = args[1] as File;
  Uint8List imgBytes = file.readAsBytesSync();
  String imageBase64 = base64Encode(imgBytes.toList());
  sendPort.send(imageBase64);
}

Future<String> upLoadImage(File image) async {
  final receivePort = ReceivePort();
  Isolate.spawn(base64EncodeFile, [receivePort.sendPort, image]);
  final dynamic imageBase64 = await receivePort.first;
  return imageBase64 as String;
}

void askForExit({
  required BuildContext context,
  required Function onBackPressed,
  required String title,
  required String description,
  required String backButtonName,
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
                buttonName: tr('admin.exit_dialogue.stay_here'),
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

void uploadDocuments(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: UploadDocumentDialogue()));
}

void editDocuments(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: EditDocumentDialogue()));
}

void uploadProfilePicture(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: UploadProfilePictureDialogue()));
}

void editProfilePicture(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) => const AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: EditProfilePictureDialogueClient()));
}
