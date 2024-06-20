import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/lab_doctor/lab_doctor.dart';
import 'package:healtha/themes/dark.dart';
import 'package:healtha/themes/light.dart';
import 'package:healtha/variables.dart';
import 'package:healtha/main.dart';
import 'package:healtha/variables.dart';
import 'package:flutter/material.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/themes/dark.dart';
import 'package:healtha/themes/light.dart';

import '../../bloc/themes/themes_bloc.dart';
import '../../bloc/themes/themes_event.dart';

class SettingsPage extends StatefulWidget {
  final Function(ThemeData) onThemeChanged;

  const SettingsPage({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeData _selectedTheme;

  @override
  void initState() {
    super.initState();
    _selectedTheme = lightTheme; // Initialize with the default theme
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).Settings),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: const Icon(Icons.color_lens, color: Color(0xff7c77d1)),
            title: Text(S.of(context).Themes),
            subtitle: Text(
              'Current: ${_selectedTheme == lightTheme ? 'Light' : 'Dark'}',
            ),
            children: <Widget>[
              ListTile(
                title: const Text('Light'),
                onTap: () {
                  setState(() {
                    _selectedTheme = lightTheme;
                  });
                  widget.onThemeChanged(lightTheme); // Notify the parent about the theme change
                },
              ),
              ListTile(
                title: const Text('Dark'),
                onTap: () {

                    BlocProvider.of<ThemesBloc>(context).add(ToggleTheme());
                  },


              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.language,
                color:  Color(0xff7c77d1)), // Set icon color to purple
            title: Text(S.of(context).Language),
            subtitle: const Text(
                'Current: English'), // Update this dynamically if needed
            children: <Widget>[
              ListTile(
                title: const Text('English'),
                onTap: () {
                  // Handle language change to English
                },
              ),
              ListTile(
                title: const Text('Arabic'),
                onTap: () {
                  // Handle language change to Arabic
                },
              ),
            ],
          ),
        ],
      ),
      //  backgroundColor: Colors.white, // Set background color to white
    );
  }
}
