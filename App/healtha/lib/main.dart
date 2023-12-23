import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healtha/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/encyclopedias/one_encyclopedia.dart';
import 'package:healtha/lab_analysis/saved_reports.dart';
import 'package:line_icons/line_icons.dart';

import 'lab_analysis/drop_file.dart';
import 'lab_analysis/report.dart';
import 'lab_analysis/upload_analysis.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const Color myPurple = Color(0xff7c77d1);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Healtha',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Merriweather',
      ),

      home: Scaffold(
        body: EncyclopediaTypes(),
        bottomNavigationBar: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              rippleColor: myPurple.withOpacity(0.2),
              hoverColor: myPurple.withOpacity(0.2),
              haptic: true,
              tabBorderRadius: 25,
              tabActiveBorder: Border.all(color: myPurple, width: 0.2),
              tabBorder: Border.all(color: Colors.grey, width: 0.2),
              tabShadow: [BoxShadow(color: Colors.white, blurRadius: 8)],
              curve: Curves.easeInExpo,
              duration: Duration(milliseconds: 200),
              gap: 5,
              color: Colors.grey[700],
              activeColor: myPurple,
              iconSize: 24,
              tabBackgroundColor: myPurple.withOpacity(0.1),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: LineIcons.heart,
                  text: 'Likes',
                ),
                GButton(
                  icon: LineIcons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: LineIcons.user,
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),

      )

    );
  }
}