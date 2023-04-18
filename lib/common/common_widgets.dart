import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/my_profile/my_profile_widgets/edit_profile_picture_dialogue_client_prof.dart';
import 'package:g_worker_app/my_profile/provider/my_profile_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/edit_profile_picture_dialogue.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/upload_profile_picture_dialogue.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/edit_document_dialogue.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/upload_document_dialogue.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Constants.dart';
import '../jobs/provider/get_client_job_list_provider.dart';

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
          insetPadding: const EdgeInsets.symmetric(horizontal: 15),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
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
    builder: (ctx) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      content: EditProfilePictureDialogueClientProf(
        cameraClick: () {
          var profilePicProvider = context.read<ProfilePicProvider>();
          var myProfileProvider = context.read<MyProfileProvider>();
          Navigator.of(context).pop();
          profilePicProvider
              .getImage(ImageSource.camera, context)
              .then((value) {
            if (value) {
              myProfileProvider.updateProfileImage(
                  profilePicProvider.getImageString.toString(), context);
            }
          });
        },
        galleryClick: () {
          var profilePicProvider = context.read<ProfilePicProvider>();
          var myProfileProvider = context.read<MyProfileProvider>();
          Navigator.of(context).pop();
          profilePicProvider
              .getImage(ImageSource.gallery, context)
              .then((value) {
            if (value) {
              myProfileProvider.updateProfileImage(
                  profilePicProvider.getImageString.toString(), context);
            }
          });
        },
        deleteClick: () {
          var myProfileProvider = context.read<MyProfileProvider>();
          Navigator.of(context).pop();
          myProfileProvider.deleteProfileImage(context);
        },
      ),
    ),
  );
}

Widget statusChip(String state, BuildContext context) {
  return Chip(
      backgroundColor: state == JobStatus.published
          ? publishedChipColor
          : state == JobStatus.accepted
              ? acceptedChipColor
              : state == JobStatus.doing
                  ? doingChipColor
                  : state == JobStatus.pending
                      ? pendingChipColor
                      : state == JobStatus.completed
                          ? completedChipColor
                          : state == JobStatus.rejected
                              ? rejectedChipColor
                              : state == JobStatus.applied
                                  ? doingChipColor.withOpacity(0.1)
                                  : state == JobStatus.expired
                                      ? rejectedChipColor.withOpacity(0.1)
                                      : state == JobStatus.reported
                                          ? reportedChipColor.withOpacity(0.1)
                                          : Colors.white,
      label: Text(tr(tr('client.job_status.${state.toLowerCase()}')),
          style: Theme.of(context).textTheme.caption!.apply(
              color: state == JobStatus.published
                  ? green26A
                  : state == JobStatus.accepted
                      ? acceptedTagTextColor
                      : state == JobStatus.applied
                          ? doingChipColor
                          : state == JobStatus.pending
                              ? primaryColor
                              : state == JobStatus.expired
                                  ? rejectedChipColor
                                  : state == JobStatus.reported
                                      ? rejectedChipColor
                                      : Colors.white)));
}

Widget confirmationDialogueView(
    {required BuildContext context,
    String? mainIcon,
    button1Name,
    button2Name,
    required String title,
    required String description,
    String button1Icon = 'arrow_circle_down.png',
    String button2Icon = 'go_backward.png',
    Color titleIconColor = primaryColor,
    Color titleIconBgColor = Colors.black12,
    Color button2TextColor = primaryColor,
    Color button1BgColor = primaryColor,
    bool showLoader = false,
    required Function onButton1Click,
    required Function onButton2Click}) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              CircleAvatar(
                radius: 40,
                backgroundColor: titleIconBgColor,
                child: Center(
                    child: mainIcon == null
                        ? Icon(
                            Icons.warning_amber_outlined,
                            size: 36,
                            color: titleIconColor,
                          )
                        : Image.asset(
                            'assets/icons/$mainIcon',
                            height: 36,
                            width: 36,
                            color: titleIconColor,
                          )),
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
                  if (!showLoader) {
                    onButton1Click();
                  }
                },
                context: context,
                backgroundColor: button1BgColor,
                buttonName:
                    button1Name ?? tr('admin.go_back_dialogue.stay_here'),
                iconAsset: button1Icon,
              ),
              const SizedBox(
                height: 10,
              ),
              submitButton(
                  onButtonTap: () {
                    if (!showLoader) {
                      onButton2Click();
                    }
                  },
                  context: context,
                  backgroundColor: Colors.transparent,
                  buttonName:
                      button2Name ?? tr('admin.go_back_dialogue.Go_back'),
                  textColor: button2TextColor,
                  iconAsset: button2Icon,
                  iconColor: button2TextColor),
            ],
          ),
          showLoader
              ? Positioned.fill(
                  child: Container(
                      color: Colors.white24,
                      child: const Center(child: CircularProgressIndicator())))
              : Container()
        ],
      ),
    ],
  );
}
