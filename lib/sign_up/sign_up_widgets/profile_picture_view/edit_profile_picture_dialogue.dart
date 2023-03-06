import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';

class EditProfilePictureDialogue extends StatelessWidget {
  const EditProfilePictureDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: whiteEFE,
          child: Image.asset("assets/icons/edit_profile.png",
              height: 24, width: 24, color: primaryColor),
        ),
        const SizedBox(height: 14),
        const Text(
          'Edit profile picture',
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 24,
              fontFamily: 'Manrope'),
        ),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upload from camera'.toUpperCase(),
              style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: 'Satoshi'),
            ),
            const SizedBox(width: 8),
            Image.asset('assets/icons/camera-plus.png', height: 24, width: 24),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upload from gallery'.toUpperCase(),
              style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: 'Satoshi'),
            ),
            const SizedBox(width: 8),
            Image.asset('assets/icons/image-plus.png', height: 24, width: 24),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'delete photo'.toUpperCase(),
              style: const TextStyle(
                  color: redE45,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  fontFamily: 'Satoshi'),
            ),
            const SizedBox(width: 8),
            Image.asset('assets/icons/trash.png', height: 24, width: 24),
          ],
        ),
        const SizedBox(height: 12),
        const Divider(thickness: 1, color: greyD3D),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CLose'.toUpperCase(),
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
      ],
    );
  }
}
