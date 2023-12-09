import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _fileName = 'No file chosen';
  bool showAfterAnimation= false;
  bool _isEnabled = true;

  int _selectedIndex = 0;
  static const Color myPurple = Color(0xff7c77d1);

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: MediaQuery.of(context).size.height*.50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: myPurple,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                ),
              ),
              Positioned(
                bottom: -275,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff7c77d1),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Proactive health starts here!",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: myPurple),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Unlocking insights with smart reports",
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

        ],
      );
  }
}
