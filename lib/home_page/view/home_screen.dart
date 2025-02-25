import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/custom_bottom_navigation_bar.dart';
import 'package:g_worker_app/dashboard/dashboard_screen.dart';
import 'package:g_worker_app/home_page/provider/home_page_provider.dart';
import 'package:g_worker_app/jobs/job_list_screen.dart';
import 'package:provider/provider.dart';

import '../../jobs/client_job_list_screen.dart';
import '../../user/user_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int role = -1;

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    context.read<HomePageProvider>().getUserRole().then((value) {
      setState(() {
        role = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return role == UserType.admin
        ? adminView()
        : role == UserType.client
            ? clientView()
            : role == UserType.professional
                ? professionalView()
                : const Center(child: Text('Something went wrong'));
  }

  Widget clientView() {
    return const ClientJobListScreen();
  }

  Widget adminView() {
    List<Widget> pages = <Widget>[
      const DashboardScreen(),
      JobListScreen(role: role),
      const UserListScreen(),
    ];
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          pages.elementAt(_selectedIndex),
          Positioned(
            bottom: 1,
            child: CustomBottomNavigationBar(
                onItemTapped: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                selected: _selectedIndex),
          )
        ],
      )),
    );
  }

  Widget professionalView() {
    return Scaffold(
      body: SafeArea(child: JobListScreen(role: role)),
    );
  }
}
