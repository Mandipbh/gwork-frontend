import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/language_screen/language.dart';
import 'package:g_worker_app/my_profile/edit_profile_screen.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';

import '../common/common_loader.dart';
import '../common/common_widgets.dart';

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
                  height: 108,
                  width: 108,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const CircleAvatar(
                          radius: 75,
                          backgroundColor: Color(0xff6DCF82),
                          child: Text(
                            'ST',
                            style: TextStyle(fontSize: 65, color: Colors.white),
                          )),
                      Positioned(
                          bottom: -2,
                          right: -8,
                          child: CircleAvatar(
                            radius: 22,
                            backgroundColor: primaryColor,
                            child: Image.asset('assets/icons/edit.png',
                                height: 22, width: 22, color: Colors.white),
                          ))
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // ProgressLoader(context);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text('ABC XYZ',
                      style: Theme.of(context).textTheme.displayMedium),
                ),
              ),
              // InkWell(
              //   onTap: () {
              //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 16),
              //     child: Text('ABC XYZ',
              //         style: Theme.of(context).textTheme.headline2),
              //   ),
              // ),
              Row(
                children: [
                  Image.asset('assets/icons/user_first_name.png',
                      height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.First_name'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('ABC', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
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
                  Image.asset('assets/icons/user.png', height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Last_name'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('XYZ', style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
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
                  Image.asset('assets/icons/mail.png', height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Email'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('xyz@email.com',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
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
                  Image.asset('assets/icons/phone.png', height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Phone_number'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('+39 000 000 0000',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.phoneNumber,
                                    value: '+39 348 613 7727',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/hash.png', height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Text_Code'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('AB876868798HFH',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
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
                  Image.asset('assets/icons/calendar_birthday.png',
                      height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Birth_Date'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('23/01/1998',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
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
                  Image.asset('assets/icons/credit_card_upload.png',
                      height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Payment_method'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('*****6576',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.paymentMethod,
                                    value: 'testt',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/password.png',
                      height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Password'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('*********',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/edit.png',
                            height: 24, width: 24),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfileScreen(
                                    type: ProfileFieldType.password,
                                    value: '*****************',
                                  )),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              Row(
                children: [
                  Image.asset('assets/icons/globe.png', height: 24, width: 24),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tr('admin.Profile.Language'),
                          style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 6),
                      Text('English',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 24,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LanguageScreen()),
                        );
                      }),
                ],
              ),
              const Divider(height: 25),
              submitButton(
                  context: context,
                  onButtonTap: () {
                    askForExit(
                      context: context,
                      onBackPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SignInSignUpScreen()),
                            (Route<dynamic> route) => false);
                      },
                      backButtonName: tr('admin.log_out_dialogue.Log_out'),
                      title: tr('admin.log_out_dialogue.are_you_sure_logout'),
                      description:
                          tr('admin.log_out_dialogue.need_to_login_again'),
                    );
                  },
                  backgroundColor: Colors.transparent,
                  iconColor: const Color(0xffE45E5E),
                  textColor: const Color(0xffE45E5E),
                  buttonName: tr('admin.log_out_dialogue.Log_out'),
                  iconAsset: 'logout.png')
            ],
          ),
        ),
      ),
    );
  }
}
