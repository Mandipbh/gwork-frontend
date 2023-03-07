import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_widgets.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:provider/provider.dart';

import '../../../colors.dart';

class ProfilePictureView extends StatefulWidget {
  const ProfilePictureView({super.key});

  @override
  State<ProfilePictureView> createState() => _ProfilePictureViewState();
}

class _ProfilePictureViewState extends State<ProfilePictureView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text('Profile Picture',
              style: Theme.of(context).textTheme.headline1),
        ),
        Text('Add payment method for your account',
            style: Theme.of(context).textTheme.bodyText2),
        const SizedBox(height: 20),
        Center(
          child: SizedBox(
            height: 150,
            width: 150,
            child: Stack(
              children: [
                Consumer<ProfilePicProvider>(
                  builder: (BuildContext context, value, Widget? child) {
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
                          : const Center(
                              child: Text(
                                'ST',
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
    );
  }
}
