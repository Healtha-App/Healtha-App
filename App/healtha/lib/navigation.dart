// your_widget.dart
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:healtha/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/profile/home.dart';
import 'package:healtha/home/home_screen.dart';
import 'package:line_icons/line_icons.dart';

import 'lab_analysis/saved_reports.dart';
import 'lab_doctor/lab_doctor.dart';

class YourWidget extends StatefulWidget {
  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomeScreen(),
          EncyclopediaTypes(),
          SavedReports(),
          ProfileScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
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
            iconSize: 26,
            tabBackgroundColor: myPurple.withOpacity(0.1),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            tabs: [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.chrome_reader_mode_outlined,
                text: 'Encyclopedia',
              ),
              GButton(
                icon: Icons.bookmark_outline_outlined,
                text: 'Saved',
              ),
              GButton(
                icon: LineIcons.user,
                text: 'Profile',
              ),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInExpo,
              );
            },
          ),
        ),
      ),
    );
  }
}
