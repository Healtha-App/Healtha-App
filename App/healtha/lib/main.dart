import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtha/screens/doctor_ui/all-doctors.dart';
import 'package:healtha/screens/doctor_ui/doc-profile.dart';
import 'package:healtha/screens/doctor_ui/requested-reports.dart';
import 'package:healtha/screens/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/home/home_screen.dart';
import 'package:healtha/screens/lab_analysis/report.dart';
import 'package:healtha/screens/lab_analysis/upload_analysis.dart';
import 'package:healtha/screens/notification/notification_center.dart';
import 'package:healtha/screens/prediction/disease_prediction.dart';
import 'package:healtha/screens/profile/profile.dart';
import 'package:healtha/screens/profile/settings.dart';
import 'package:healtha/screens/register_login/join_as.dart';
import 'package:healtha/screens/start/option.dart';
import 'package:healtha/screens/start/splash.dart';
import 'package:healtha/themes/light.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/themes/themes_bloc.dart';
import 'bloc/themes/themes_event.dart';
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
              theme: (state is ThemeLight) ? darkTheme : darkTheme,
              home: AllDoctors(),
            ),
          );
        },
      ),
    );
  }
}
