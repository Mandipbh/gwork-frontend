import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/home_page/provider/home_page_provider.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
import 'package:g_worker_app/jobs/provider/get_job_list_provider.dart';
import 'package:g_worker_app/language_screen/language_provider/language_provider.dart';
import 'package:g_worker_app/my_profile/provider/my_profile_provider.dart';
import 'package:g_worker_app/recover_password/provider/recover_password_provider.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:g_worker_app/sign_up/registration_screen.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/document_provider/document_provider.dart';
import 'package:g_worker_app/splash_screen.dart';

import 'package:provider/provider.dart';

import 'jobs/add_job_widgets/upload_images_view.dart';
import 'sign_in/provider/sign_in_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: whiteF2F,
    statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
    statusBarBrightness: Brightness.light,
  ));
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('it')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translate',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static int apkType = UserType.professional;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfilePicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DocumentPicProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UploadImageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomePageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SignUpProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MyProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => RecoverPasswordProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => GetClientJobListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CreateClientJobProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'g.work',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: whiteF2F,
            primaryColor: primaryColor,
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.transparent),
            inputDecorationTheme: const InputDecorationTheme(
              border: InputBorder.none,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              helperStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              labelStyle: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: labelColor),
            ),
            appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Satoshi',
                  color: primaryColor),
              centerTitle: true,
              elevation: 0.5,
              backgroundColor: whiteF2F,
              iconTheme: IconThemeData(color: primaryColor),
            ),
            textTheme: const TextTheme(
              // for all headings
              headline1: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              // for dialog header
              headline2: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              // for appbar title

              headline3: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Satoshi',
                  color: primaryColor),

              headline4: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              headline5: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              // for labels
              headline6: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),

              // for login page tags
              subtitle1: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: Color(0xff19201A)),
              // for notification
              subtitle2: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              bodyText1: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700),
              // for description and input field
              bodyText2: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              // all fields label
              caption: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              // button text
              button: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            dividerTheme:
                const DividerThemeData(color: Color(0xffD3DCD7), thickness: 1)),
        home: const SplashScreen(),
      ),
    );
  }
}
