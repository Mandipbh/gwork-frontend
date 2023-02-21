import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
