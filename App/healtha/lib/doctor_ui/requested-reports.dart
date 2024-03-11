import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/doctor_ui/doc-profile.dart';

import 'open-report.dart';

class requestedReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE0E7EA), // Light blue
                  Color(0xff7c77d1).withOpacity(0.2), // Light grey
                ],
              ),
            ),
          ),
          // Abstract Shapes
          Positioned(
            top: -screenSize.width * 0.3,
            right: -screenSize.width * 0.1,
            child: Container(
              width: screenSize.width * 0.6,
              height: screenSize.width * 0.6,
              decoration: BoxDecoration(
                color: Color(0xFF7C77D1), // Purple
                borderRadius: BorderRadius.circular(screenSize.width * 0.3),
              ),
            ),
          ),
          Positioned(
            top: screenSize.height * 0.3,
            left: -screenSize.width * 0.2,
            child: Container(
              width: screenSize.width * 0.4,
              height: screenSize.width * 0.4,
              decoration: BoxDecoration(
                color: Color(0xFF7C77D1), // Purple
                borderRadius: BorderRadius.circular(screenSize.width * 0.2),
              ),
            ),
          ),
          // Small circle at the bottom right
          Positioned(
            bottom: screenSize.height * 0.01,
            right: screenSize.width * 0.01,
            child: Container(
              width: screenSize.width * 0.2,
              height: screenSize.width * 0.2,
              decoration: BoxDecoration(
                color: Color(0xFF7C77D1), // Purple
                borderRadius: BorderRadius.circular(screenSize.width * 0.1),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkResponse(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => drProfile()),
                    );
                  },
                  child: CircleAvatar(
                    radius: screenSize.width * 0.1,
                    backgroundImage: AssetImage("images/dr.PNG"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenSize.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenSize.height * 0.13), // Adjust as needed
                Text(
                  'Requested Reports', // Your healthcare app name
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Dark blue
                  ),
                ),
                SizedBox(height: screenSize.height * 0.02),
                // Add more widgets as needed
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenSize.width * 0.01),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.2),
                Container(
                  width: double.infinity,
                 // height: screenSize.height * 0.1,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(screenSize.width * 0.05)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white70.withOpacity(0.8),
                        blurRadius: 1,
                      //  offset: Offset(0, screenSize.width * 0.04),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(screenSize.width * 0.02),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        "Rahma Khaled",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C77D1),
                        ),
                      ),
                      subtitle: Text(
                        "Golocoz analysis",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w100,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => openReport()),
                          );
                        },
                        elevation: 2.0,
                        fillColor: Color(0xFF7C77D1),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.065,
                        ),
                        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
                        shape: CircleBorder(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
