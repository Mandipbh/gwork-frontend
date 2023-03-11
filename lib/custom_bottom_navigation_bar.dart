import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/colors.dart';
import 'package:badges/badges.dart' as badges;

class CustomBottomNavigationBar extends StatelessWidget {
  Function onItemTapped;
  int selected;

  CustomBottomNavigationBar(
      {super.key, required this.onItemTapped, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 25.0,
        ),
      ]),
      width: MediaQuery.of(context).size.width,
      child: Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onItemTapped(0);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: selected == 0 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/images/home-smile.png",
                          height: 24,
                          width: 24,
                          color: selected == 0 ? Colors.white : Colors.black),
                      const SizedBox(height: 4),
                      Text(
                        tr('admin.dashboard.Home').toUpperCase(),
                        style: TextStyle(
                            color: selected == 0 ? Colors.white : black343,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onItemTapped(1);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: selected == 1 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/briefcase.png",
                        height: 24,
                        width: 24,
                        color: selected == 1 ? Colors.white : Colors.black,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('admin.dashboard.Jobs').toUpperCase(),
                        style: TextStyle(
                            color: selected == 1 ? Colors.white : black343,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onItemTapped(2);
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: selected == 2 ? Colors.black : Colors.white,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      badges.Badge(
                        badgeContent: const Text('12'),
                        position:
                            badges.BadgePosition.topEnd(top: -13, end: -15),
                        badgeStyle: badges.BadgeStyle(
                          shape: badges.BadgeShape.square,
                          borderRadius: BorderRadius.circular(8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 3),
                          badgeColor: yellowF4D,
                        ),
                        child: Image.asset(
                          "assets/images/users.png",
                          height: 24,
                          width: 24,
                          color: selected == 2 ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        tr('admin.dashboard.Users').toUpperCase(),
                        style: TextStyle(
                            color: selected == 2 ? Colors.white : black343,
                            fontFamily: 'Satoshi',
                            fontWeight: FontWeight.w700,
                            fontSize: 12),
                      )
                    ],
                  ),
                ),
              )),
            ],
          )),
    );
  }
}
