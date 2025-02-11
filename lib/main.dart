import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/home_page/provider/home_page_provider.dart';
import 'package:g_worker_app/language_screen/language_provider/language_provider.dart';
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

  static int apkType = UserType.client;

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
        )
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
              displayLarge: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              // for dialog header
              displayMedium: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              // for appbar title

              displaySmall: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Satoshi',
                  color: primaryColor),

              headlineMedium: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              headlineSmall: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              // for labels
              titleLarge: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),

              // for login page tags
              titleMedium: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: Color(0xff19201A)),
              // for notification
              titleSmall: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
              bodyLarge: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700),
              // for description and input field
              bodyMedium: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Manrope',
                  fontWeight: FontWeight.w500,
                  color: primaryColor),
              // all fields label
              bodySmall: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
              // button text
              labelLarge: TextStyle(
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
