import 'package:flutter/material.dart';

import '../colors.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({super.key});

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            'Payment Method',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Text('Add payment method for your account',
            style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        Center(
          child: Container(
            height: 150,
            width: 150,
            child: Stack(
              children: const [
                CircleAvatar(
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
                      radius: 25,
                      backgroundColor: primaryColor,
                      child: Icon(Icons.cloud_upload_outlined,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }
}
