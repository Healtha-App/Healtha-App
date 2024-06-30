import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/doctor/doc_signUp.dart';
import 'package:healtha/screens/general/home/home_screen.dart';
import 'package:healtha/screens/patient/register_login/log_in.dart';
import 'package:healtha/screens/patient/register_login/sign_up.dart';
import 'package:healtha/themes/light.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/themes/themes_bloc.dart';
import 'screens/general/navigation/navigation.dart';
import 'themes/dark.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemesBloc(),
      child: BlocBuilder<ThemesBloc, ThemesState>(
        builder: (context, state) {
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
              theme: (state is ThemeLight) ? darkTheme : lightTheme,
              home: Login(),
            ),
          );
        },
      ),
    );
  }
}
