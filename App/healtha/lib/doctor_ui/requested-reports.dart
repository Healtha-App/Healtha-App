import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/doctor_ui/doc-profile.dart';

import 'open-report.dart';

class requestedReports extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            top: -150,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                color: Color(0xFF7C77D1), // Purple
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: -80,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Color(0xFF7C77D1), // Purple
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          // Small circle at the bottom right
          Positioned(
            bottom: 3,
            right: 5,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xFF7C77D1), // Purple
                borderRadius: BorderRadius.circular(70),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(25.0),
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
                    radius: 40,
                    backgroundImage: AssetImage("images/dr.PNG"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 130), // Adjust as needed
                Text(
                  'Requested Reports', // Your healthcare app name
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Dark blue
                  ),
                ),
                SizedBox(height: 20),
                // Add more widgets as needed
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 200,),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white70.withOpacity(0.8),
                        blurRadius: 1,
                        offset: Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:  EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Rahma Khaled",style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF7C77D1)
                            ),),
                            Text("Golocoz analysis",style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w100,
                                color: Colors.black87
                            ),),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            SizedBox(height: 10,),
                            RawMaterialButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => openReport()));
                              },
                              elevation: 2.0,
                              fillColor: Color(0xFF7C77D1), // Set button color
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white, // Set icon color to white
                                size: 24.0,
                              ),
                              padding: EdgeInsets.all(15.0),
                              shape: CircleBorder(),
                            ),
                          ],
                        ),
                      ],
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
