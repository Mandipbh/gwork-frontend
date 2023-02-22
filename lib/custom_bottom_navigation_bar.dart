import 'package:flutter/material.dart';

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
                  child: InkWell(
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
                      Icon(
                        Icons.home_outlined,
                        color: selected == 0 ? Colors.white : Colors.black,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Home',
                        style: TextStyle(
                          color: selected == 0 ? Colors.white : Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: InkWell(
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
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: selected == 1 ? Colors.white : Colors.black,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Jobs',
                        style: TextStyle(
                          color: selected == 1 ? Colors.white : Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                  child: InkWell(
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
                      Icon(
                        Icons.person_outline,
                        color: selected == 2 ? Colors.white : Colors.black,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Users',
                        style: TextStyle(
                          color: selected == 2 ? Colors.white : Colors.black,
                        ),
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
