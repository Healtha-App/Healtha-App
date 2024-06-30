import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/themes/light.dart';

import 'package:healtha/bloc/themes/themes_bloc.dart';
import 'package:healtha/bloc/themes/themes_event.dart';

class SettingsPage extends StatefulWidget {
  final Function(ThemeData) onThemeChanged;

  const SettingsPage({Key? key, required this.onThemeChanged})
      : super(key: key);

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
        title: Text(
          S.of(context).Settings,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.onPrimary), // Specify the color of the leading icon
      ),

      body: ListView(
        children: <Widget>[
          ExpansionTile(
            leading: const Icon(Icons.color_lens, color: Color(0xff7c77d1)),
            title: Text(S.of(context).Themes,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),),
            subtitle: Text(
              'Current: ${_selectedTheme == lightTheme ? 'Dark' : 'Dark'}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
            ),
            children: <Widget>[
              ListTile(
                title: Text(
                  'Light',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                onTap: () {
                  setState(() {
                    _selectedTheme = lightTheme;
                  });
                  widget.onThemeChanged(
                      lightTheme); // Notify the parent about the theme change
                },
              ),
              ListTile(
                title: Text('Dark',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),),
                onTap: () {
                  BlocProvider.of<ThemesBloc>(context).add(ToggleTheme());
                },
              ),
            ],
          ),
          ExpansionTile(
            leading: const Icon(Icons.language,
                color: Color(0xff7c77d1)), // Set icon color to purple
            title: Text(S.of(context).Language,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),),
            subtitle: Text(
                'Current: English',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ), // Update this dynamically if needed
            children: <Widget>[
              ListTile(
                title:  Text('English',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),),
                onTap: () {
                  // Handle language change to English
                },
              ),
              ListTile(
                title:  Text('Arabic',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),),
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
