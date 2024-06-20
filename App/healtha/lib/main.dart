import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtha/screens/doctor_ui/doc-profile.dart';
import 'package:healtha/screens/doctor_ui/requested-reports.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/home/home_screen.dart';
import 'package:healtha/screens/lab_analysis/report.dart';
import 'package:healtha/screens/notification/notification_center.dart';
import 'package:healtha/screens/profile/profile.dart';
import 'package:healtha/screens/start/option.dart';
import 'package:healtha/screens/start/splash.dart';
import 'package:healtha/themes/light.dart';

import 'themes/dark.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static Color myPurple = const Color(0xff7c77d1);
  final ThemeData themeData = darkTheme;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Healtha',
        locale: const Locale('en'),
        debugShowCheckedModeBanner: false,
        supportedLocales: S.delegate.supportedLocales,
        // theme: themeData,
        home: SplashScreen(),
      ),
    );
  }
}
