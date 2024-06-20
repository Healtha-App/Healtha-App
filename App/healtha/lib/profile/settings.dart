import 'package:flutter/material.dart';
import 'package:healtha/generated/l10n.dart';
import 'package:healtha/lab_doctor/lab_doctor.dart';
import 'package:healtha/themes/dark.dart';
import 'package:healtha/themes/light.dart';
import 'package:healtha/variables.dart';
import '../main.dart';
import 'package:healtha/variables.dart';
class SettingsPage extends StatefulWidget {
  final Function(ThemeData)
      onThemeChanged; // Add a callback function to handle theme changes

  const SettingsPage(
      {super.key,
      required this.onThemeChanged}); // Constructor for the callback function

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeData _selectedTheme; // Initialize with a default theme

  @override
  void initState() {
    super.initState();
    // Initialize the selected theme with the default theme set in MyApp
    _selectedTheme = ThemeData.light();
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
            leading: const Icon(Icons.color_lens,
                color:  Color(0xff7c77d1) ),
            title: Text(S.of(context).Themes),
            subtitle: Text(
                'Current: ${_selectedTheme == lightTheme ? 'Light' : 'Dark'}'),
            children: <Widget>[
              ListTile(
                title: const Text('Light'),
                onTap: () {
                  setState(() {
                    _selectedTheme = lightTheme;
                  });
                  widget.onThemeChanged(
                      lightTheme); // Call the callback function with light theme
                },
              ),
              ListTile(
                title: const Text('Dark'),
                onTap: () {
                  setState(() {
                    _selectedTheme = darkTheme;
                  });
                  widget.onThemeChanged(
                      darkTheme); // Call the callback function with dark theme
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
