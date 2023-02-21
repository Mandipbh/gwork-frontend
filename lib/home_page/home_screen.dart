import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/custom_bottom_navigation_bar.dart';
import 'package:g_worker_app/dashboard/dashboard_screen.dart';
import 'package:g_worker_app/jobs/job_list_screen.dart';

import '../user/user_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = <Widget>[
    DashboardScreen(),
    JobListScreen(),
    UserListScreen(),
  ];

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
      statusBarIconBrightness: Brightness.light, // For Android (dark icons)
      statusBarBrightness: Brightness.dark,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Stack(
        children: [
          _pages.elementAt(_selectedIndex),
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
}
