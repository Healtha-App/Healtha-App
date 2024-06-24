import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:healtha/screens/patient/chatbot/chat_screen.dart';
import 'package:healtha/screens/doctor/all-doctors.dart';
import 'package:healtha/screens/doctor/doc-profile.dart';
import 'package:healtha/screens/doctor/requested-reports.dart';
import 'package:healtha/screens/general/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/general/home/home_screen.dart';
import 'package:healtha/screens/patient/lab_analysis/report.dart';
import 'package:healtha/screens/patient/lab_analysis/upload_analysis.dart';
import 'package:healtha/screens/patient/notification/notification_center.dart';
import 'package:healtha/screens/patient/prediction/disease_prediction.dart';
import 'package:healtha/screens/patient/prediction/static_disease_prediction.dart';
import 'package:healtha/screens/patient/profile/profile.dart';
import 'package:healtha/screens/patient/profile/settings.dart';
import 'package:healtha/screens/patient/register_login/join_as.dart';
import 'package:healtha/screens/general/start/option.dart';
import 'package:healtha/screens/general/start/splash.dart';
import 'package:healtha/themes/light.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/themes/themes_bloc.dart';
import 'bloc/themes/themes_event.dart';
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
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
