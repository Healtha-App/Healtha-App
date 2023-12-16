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
                bottom: -350,
                left: MediaQuery.of(context).size.width * 0.05,
                right: MediaQuery.of(context).size.width * 0.05,
                child: Container(
                  padding: EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 720,
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
                        """Dear Esraa,

We hope this report finds you in good health. We have conducted a comprehensive lab analysis to assess your overall health, with a specific focus on your haemoglobin levels and thyroid health. Below, you will find the results of the analysis along with some tips for managing your thyroid health.

1. Haemoglobin Level:
Your haemoglobin level is measured at 12.9 g/dL. Haemoglobin is a protein found in red blood cells that carries oxygen throughout the body. The normal range for haemoglobin in women is typically between 12.0 and 15.5 g/dL. Based on your results, your haemoglobin level falls within the normal range, indicating that your blood is carrying an adequate amount of oxygen.

Please note that this report is based on the results of the lab analysis conducted on 10-10-2023. It is essential to consult with your healthcare provider for a comprehensive evaluation of your health and to discuss any concerns or questions you may have.

Take care of your health and follow the tips provided to maintain optimal thyroid health. Should you have any further questions or require additional information, please do not hesitate to reach out to us.

Wishing you good health and well-being.
    """,
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
