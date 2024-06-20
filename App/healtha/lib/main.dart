import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtha/doctor_ui/doc-profile.dart';
import 'package:healtha/doctor_ui/requested-reports.dart';
import 'package:healtha/generated/l10n.dart';
import 'package:healtha/home/home_screen.dart';
import 'package:healtha/lab_analysis/report.dart';
import 'package:healtha/notification/notification_center.dart';
import 'package:healtha/profile/profile.dart';
import 'package:healtha/start/option.dart';
import 'package:healtha/start/splash.dart';
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
  final ThemeData themeData = lightTheme;
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
        home: RequestedReports(),
      ),
    );
  }
}
