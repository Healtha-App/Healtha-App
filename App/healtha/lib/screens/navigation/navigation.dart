import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/lab_analysis/upload_analysis.dart';
import 'package:healtha/main.dart';
import 'package:healtha/screens/profile/profile.dart';
import 'package:healtha/themes/dark.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

import '../chatbot/chat_screen.dart';
import '../encyclopedias/encyclopedia_types.dart';
import '../home/home_screen.dart';
import '../notification/notification_center.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentTap = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const EncyclopediaTypes(),
    const NotificationCenter(),
    const ProfileScreen(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.height * 0.19,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xff7c77d1).withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UploadPage()),
              );
            },
            elevation: 2.0,
            fillColor:
                MyApp().themeData == darkTheme ? Colors.black : Colors.white,
            padding: const EdgeInsets.all(12.0),
            shape: const CircleBorder(),
            child: Icon(
              Icons.cloud_upload_outlined, // Use the upload icon
              color: currentTap == 0 ? const Color(0xff7c77d1) : Colors.grey,
              size: 35,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        //shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 40,
          child: Center(
            // Wrap the Row with Center
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomeScreen();
                          currentTap = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            color: currentTap == 0
                                ? const Color(0xff7c77d1)
                                : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            S.of(context).Home,
                            style: TextStyle(
                              color: currentTap == 0
                                  ? const Color(0xff7c77d1)
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const ChatScreen();
                          currentTap = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidComment,
                            color: currentTap == 1
                                ? const Color(0xff7c77d1)
                                : Colors.grey,
                          ),
                          Text(
                            S.of(context).Chatting,
                            style: TextStyle(
                              color: currentTap == 1
                                  ? const Color(0xff7c77d1)
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const NotificationCenter();
                          currentTap = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications,
                            color: currentTap == 3
                                ? const Color(0xff7c77d1)
                                : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            S.of(context).Notifications,
                            style: TextStyle(
                              color: currentTap == 3
                                  ? const Color(0xff7c77d1)
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = const ProfileScreen();
                          currentTap = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person,
                            color: currentTap == 4
                                ? const Color(0xff7c77d1)
                                : Colors.grey,
                            size: 30,
                          ),
                          Text(
                            S.of(context).Profile,
                            style: TextStyle(
                              color: currentTap == 4
                                  ? const Color(0xff7c77d1)
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
