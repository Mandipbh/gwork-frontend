import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/my_profile/edit_profile_screen.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteF2F,
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Stack(
                    children: [
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
                            radius: 25,
                            backgroundColor: primaryColor,
                            child: Image.asset('assets/icons/ic_edit.png',
                                color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('ABC XYZ',
                    style: Theme.of(context).textTheme.headline2),
              ),
              Row(
                children: [
                  Image.asset('assets/icons/ic_user_firstname.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('ABC', style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.firstName,
                                    value: 'ABC',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_user.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Last Name',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('XYZ', style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.lastName,
                                    value: 'xYZ',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_email.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('xyz@email.com',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.email,
                                    value: 'xyz@email.com',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_phone.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone Number',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('+39 000 000 0000',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => EditProfileScreen(
                        //             type: ProfileFieldType.password,
                        //             value: 'testt',
                        //           )),
                        // );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_hash.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('VAT Number',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('AB876868798HFH',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.vatNumber,
                                    value: 'AB876868798HFH',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_calender_heart.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Birth Date',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('23/01/1998',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.birthdate,
                                    value: '23/01/1998',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_hash.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment Method',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('*****6576',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => EditProfileScreen(
                        //             type: ProfileFieldType.password,
                        //             value: 'testt',
                        //           )),
                        // );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/ic_password_lock.png'),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password',
                          style: Theme.of(context).textTheme.headline6),
                      const SizedBox(height: 6),
                      Text('*********',
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/ic_edit.png'),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.password,
                                    value: 'testt',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              submitButton(
                  context: context,
                  onButtonTap: () {},
                  backgroundColor: Colors.transparent,
                  iconColor: const Color(0xffE45E5E),
                  textColor: const Color(0xffE45E5E),
                  buttonName: 'logout',
                  iconAsset: 'ic_logout.png')
            ],
          ),
        ),
      ),
    );
  }
}
