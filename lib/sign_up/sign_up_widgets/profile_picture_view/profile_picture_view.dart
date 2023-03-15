import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_widgets.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:provider/provider.dart';

import '../../../colors.dart';
import '../../provider/sign_up_provider.dart';

class ProfilePictureView extends StatefulWidget {
  const ProfilePictureView({super.key});

  @override
  State<ProfilePictureView> createState() => _ProfilePictureViewState();
}

class _ProfilePictureViewState extends State<ProfilePictureView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
      builder: (context, signUpProvider, child) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(
                      tr('Professional.logIn.onBoardingDocuments1.Profile_picture'),
                      style: Theme.of(context).textTheme.headline1),
                ),
                Text(
                    tr('Professional.logIn.onBoardingDocuments1.Upload_a_picture_for_your_profile'),
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Stack(
                      children: [
                        Consumer<ProfilePicProvider>(
                          builder:
                              (BuildContext context, value, Widget? child) {
                            return Container(
                              height: 150,
                              width: 150,
                              decoration: const BoxDecoration(
                                color: Color(0xff6DCF82),
                                shape: BoxShape.circle,
                              ),
                              child: value.imagePath != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(150),
                                      child: Image.file(
                                        File(value.imagePath),
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        Provider.of<SignUpProvider>(context,
                                                    listen: false)
                                                .name!
                                                .substring(0, 1)
                                                .toUpperCase() +
                                            Provider.of<SignUpProvider>(context,
                                                    listen: false)
                                                .lastName!
                                                .substring(0, 1)
                                                .toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 65, color: Colors.white),
                                      ),
                                    ),
                            );
                          },
                        ),
                        Positioned(
                            bottom: 1,
                            right: 2,
                            child: GestureDetector(
                              onTap: () {
                                uploadProfilePicture(context);
                              },
                              child: CircleAvatar(
                                backgroundColor: whiteF2F,
                                radius: 25,
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: primaryColor,
                                  child: Image.asset(
                                    'assets/icons/profile_upload.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                )
              ],
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
    );
  }
}
