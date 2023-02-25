import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/colors.dart';
import 'package:g_worker_app/splash_screen.dart';

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
      fallbackLocale: const Locale('it'),
      path: 'assets/translate',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static int userType = UserType.admin;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'g.work',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: whiteF2F,
          primaryColor: primaryColor,
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
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
            // for labels
            headline6: TextStyle(
                fontSize: 12,
                fontFamily: 'Satoshi',
                fontWeight: FontWeight.w500,
                color: primaryColor),
            // for appbar title
            headline3: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Satoshi',
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
          dividerTheme: const DividerThemeData(color: Color(0xffD3DCD7), thickness: 1)),
      home: const SplashScreen(),
    );
  }
}
