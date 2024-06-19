import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtha/generated/l10n.dart';
import 'package:healtha/start/splash.dart';

import 'themes/dark.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  static Color myPurple = const Color(0xff7c77d1);
  final ThemeData themeData = darkTheme; // Define your theme here
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const SplashScreen(),
    );
  }
}
