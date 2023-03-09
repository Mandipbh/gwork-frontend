import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UploadProfilePictureDialogue extends StatelessWidget {
  const UploadProfilePictureDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: whiteEFE,
          child: Image.asset("assets/icons/upload.png",
              height: 24, width: 24, color: primaryColor),
        ),
        const SizedBox(height: 14),
        Text(
          tr('Professional.logIn.UploadPhotoDialog.Upload_profile_picture'),
          style: const TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: 'Manrope'),
        ),
        const SizedBox(height: 35),
        Consumer<ProfilePicProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return GestureDetector(
              onTap: () {
                value.getImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('Professional.logIn.UploadPhotoDialog.Upload_from_camera')
                        .toUpperCase(),
                    style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Satoshi'),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/camera-plus.png',
                      height: 24, width: 24),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        Consumer<ProfilePicProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return GestureDetector(
              onTap: () {
                value.getImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    tr('Professional.logIn.UploadPhotoDialog.Upload_from_gallery')
                        .toUpperCase(),
                    style: const TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'Satoshi'),
                  ),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/image-plus.png',
                      height: 24, width: 24),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                tr('Professional.logIn.UploadPhotoDialog.CLose').toUpperCase(),
                style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Satoshi'),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.close, size: 20),
            ],
          ),
        ),
      ],
    );
  }
}
