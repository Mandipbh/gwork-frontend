import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/common/common_buttons.dart';
import 'package:g_worker_app/language_screen/language.dart';
import 'package:g_worker_app/my_profile/my_profile_widgets/edit_profile_screen.dart';
import 'package:g_worker_app/my_profile/provider/my_profile_provider.dart';
import 'package:g_worker_app/shared_preference_data.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';
import 'package:provider/provider.dart';
import '../../common/common_widgets.dart';
import '../../sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';

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
      body: Consumer<MyProfileProvider>(
        builder: (context, myProfileProvder, child) {
          if (myProfileProvder.model == null) {
            myProfileProvder.getUserProfile(context);
          }
          return myProfileProvder.model == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
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
                                SizedBox(
                                  width: 140,
                                  height: 140,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(60.0),
                                    child: Image.network(
                                      myProfileProvder.model!.user!.image!,
                                      fit: BoxFit.fill,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return CircleAvatar(
                                            radius: 75,
                                            backgroundColor:
                                                const Color(0xff6DCF82),
                                            child: Text(
                                              '${myProfileProvder.model!.user!.name!.substring(0, 1)}${myProfileProvder.model!.user!.surname!.substring(0, 1)}',
                                              style: const TextStyle(
                                                  fontSize: 65,
                                                  color: Colors.white),
                                            ));
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: -2,
                                    right: -8,
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            "img1==>${Provider.of<ProfilePicProvider>(context, listen: false).getImageString}");
                                        print(
                                            "img2==>${Provider.of<MyProfileProvider>(context, listen: false).model!.user!.image}");

                                        editProfilePicture(context);
                                      },
                                      child: CircleAvatar(
                                        radius: 22,
                                        backgroundColor: primaryColor,
                                        child: Image.asset(
                                            'assets/icons/edit.png',
                                            height: 22,
                                            width: 22,
                                            color: Colors.white),
                                      ),
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
                            child: Text(
                                '${myProfileProvder.model!.user!.name!} ${myProfileProvder.model!.user!.surname!}',
                                style: Theme.of(context).textTheme.headline2),
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
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.name!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              value: myProfileProvder
                                                  .model!.user!.name!,
                                            )),
                                  );
                                }),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          children: [
                            Image.asset('assets/icons/user.png',
                                height: 24, width: 24),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('admin.Profile.Last_name'),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.surname!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              value: myProfileProvder
                                                  .model!.user!.surname!,
                                            )),
                                  );
                                }),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          children: [
                            Image.asset('assets/icons/mail.png',
                                height: 24, width: 24),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('admin.Profile.Email'),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.email!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              value: myProfileProvder
                                                  .model!.user!.email!,
                                            )),
                                  );
                                }),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          children: [
                            Image.asset('assets/icons/phone.png',
                                height: 24, width: 24),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('admin.Profile.Phone_number'),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.phoneNumber!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              type:
                                                  ProfileFieldType.phoneNumber,
                                              value: myProfileProvder
                                                  .model!.user!.phoneNumber!,
                                            )),
                                  );
                                }),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          children: [
                            Image.asset('assets/icons/hash.png',
                                height: 24, width: 24),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('admin.Profile.Text_Code'),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.vatNumber!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              value: myProfileProvder
                                                  .model!.user!.vatNumber!,
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
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.birthDate!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              value: myProfileProvder
                                                  .model!.user!.birthDate!,
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
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text(myProfileProvder.model!.user!.cardNumber!,
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                              type: ProfileFieldType
                                                  .paymentMethod,
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
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text('*********',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                            Image.asset('assets/icons/globe.png',
                                height: 24, width: 24),
                            const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr('admin.Profile.Language'),
                                    style:
                                        Theme.of(context).textTheme.headline6),
                                const SizedBox(height: 6),
                                Text('English',
                                    style:
                                        Theme.of(context).textTheme.bodyText2),
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
                                        builder: (context) =>
                                            const LanguageScreen()),
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
                                  Provider.of<MyProfileProvider>(context,
                                          listen: false)
                                      .clearProfileProvider();
                                  SharedPreferenceData().clearPrefs();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignInSignUpScreen()),
                                      (Route<dynamic> route) => false);
                                },
                                backButtonName:
                                    tr('admin.log_out_dialogue.Log_out'),
                                title: tr(
                                    'admin.log_out_dialogue.are_you_sure_logout'),
                                description: tr(
                                    'admin.log_out_dialogue.need_to_login_again'),
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
                );
        },
      ),
    );
  }
}
