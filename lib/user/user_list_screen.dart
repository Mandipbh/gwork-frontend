import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';

import '../common/common_buttons.dart';
import '../my_profile/my_profile_screen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int selected = UserFilters.registered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      body: Stack(
        children: [
          appBarView(),
          Container(
            margin: const EdgeInsets.only(top: 160),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: whiteF2F,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child: Container(
                  margin: const EdgeInsets.all(16),
                  child: userListView(
                      selected == UserFilters.registered ? 10 : 0)),
            ),
          ),
        ],
      ),
    );
  }

  Widget appBarView() {
    return Container(
      color: const Color(0xff1B1F1C),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                tr('admin.dashboard.Users'),
                style: const TextStyle(
                  fontFamily: 'Satoshi',
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child:
                      Text("ST", style: Theme.of(context).textTheme.headline1),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyProfileScreen()),
                  );
                },
              )
            ],
          ),
          const SizedBox(height: 20),
          singleSelectionButtons(
              context: context,
              buttons: [
                tr('admin.users.Registered'),
                tr('admin.job_detail.Applications')
              ],
              padding: 8,
              selected: selected,
              onSelectionChange: (value) {
                setState(() {
                  selected = value;
                });
              }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget userListView(int itemsLength) {
    if (itemsLength > 0) {
      return ListView.separated(
          itemBuilder: (context, index) => userListItemView(),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: itemsLength);
    } else {
      return emptyListView();
    }
  }

  Widget userListItemView() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: whiteF2F,
                radius: 25,
                child: Image.asset("assets/images/Ellipse.png"),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Brooklyn Simmons',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Manrope',
                        color: blue221),
                  ),
                  SizedBox(height: 4),
                  Text('Worker',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff807E93))),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Text(
                '03/23/2322',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                    color: Color(0xff9EA6A0)),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 24,
              )
            ],
          )
        ],
      ),
    );
  }

  Widget emptyListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/empty_users.png'),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              Text(
                tr('admin.users.no_application'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Satoshi',
                    color: primaryColor),
              ),
              const SizedBox(height: 4),
              Text(
                tr('admin.users.check_letter'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 2,
                  fontFamily: 'Satoshi',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 100,
        ),
      ],
    );
  }
}
