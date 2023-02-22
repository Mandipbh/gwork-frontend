import 'package:flutter/material.dart';

import '../../colors.dart';

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
              children:  [
                const CircleAvatar(
                    radius: 75,
                    backgroundColor: Color(0xff6DCF82),
                    child: Text(
                      'ST',
                      style: TextStyle(fontSize: 65, color: Colors.white),
                    )),
                Positioned(
                    bottom: 1,
                    right: 2,
                    child: CircleAvatar(
                      backgroundColor: whiteF2F,
                      radius: 25,
                      child: CircleAvatar(
                        radius: 22,
                        backgroundColor: primaryColor,
                        child: Image.asset('assets/icons/profile_upload.png',height: 30,width: 30,),
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
