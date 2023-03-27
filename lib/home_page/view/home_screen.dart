import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/custom_bottom_navigation_bar.dart';
import 'package:g_worker_app/dashboard/dashboard_screen.dart';
import 'package:g_worker_app/home_page/provider/home_page_provider.dart';
import 'package:g_worker_app/jobs/professional_job_list_screen.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

import '../../jobs/client_job_list_screen.dart';
import '../../my_profile/provider/my_profile_provider.dart';
import '../../user/user_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int role = 1;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    context.read<HomePageProvider>().getUserRole().then((value) {
      log(value.toString());
      //TODO get province list
      Provider.of<SignUpProvider>(context, listen: false)
          .getProvinceList(context);
      Provider.of<SignUpProvider>(context, listen: false).updateUserType(value);
      Provider.of<MyProfileProvider>(context, listen: false)
          .getUserProfile(context);
      setState(() {
        role = Provider.of<SignUpProvider>(context, listen: false).userType!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO remove this
    //
    // if (kDebugMode) {
    //   print("this is nulll role $role");
    //   role == -1 ? role = UserType.client : role = UserType.client;
    // }

    //
    log(role.toString());
    return role == UserType.client
        ? clientView()
        : role == UserType.professional
            ? professionalView()
            : const Center(child: Text('Something went wrong'));
  }

  Widget clientView() {
    return const ClientJobListScreen();
  }

  Widget professionalView() {
    return Scaffold(
      body: SafeArea(child: ProfessionalJobListScreen(role: role)),
    );
  }
}
