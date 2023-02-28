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
              const Text(
                'Users',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              GestureDetector(
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25,
                  child: Icon(Icons.person, color: Colors.grey, size: 25),
                ),
                onTap: (){
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
              buttons: ['Registered (48)','Applications (0)'],
              padding: 8,
              selected: selected, onSelectionChange: (value){
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
              const CircleAvatar(
                backgroundColor: whiteF2F,
                radius: 25,
                child: Icon(Icons.person, color: Colors.grey, size: 25),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Brooklyn Simmons',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                  SizedBox(height: 4),
                  Text('Worker',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Color(0xff807E93))),
                ],
              ),
            ],
          ),
          Row(
            children: const [
              Text('03/23/2322',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700,color: Color(0xff9EA6A0)),),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios_rounded,size: 24,)
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
            children: const [
              Text("There is no applications for now",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              SizedBox(height: 4),
              Text("Check it bit later please",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
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
