import 'dart:ui';
import 'package:flutter/material.dart';

class openReport extends StatelessWidget {
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
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.white.withOpacity(0.1),
                width: double.infinity,
                height: 100,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 700,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white70.withOpacity(0.6),
                        blurRadius: 1,
                        offset: Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Add more widgets as needed

                        Spacer(), // To push buttons to the bottom

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle first button press
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF7C77D1), // Set button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: Text('Edit',style:
                                TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                            SizedBox(width: 10), // Add some space between buttons
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // Handle second button press
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF7C77D1), // Set button color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                ),
                                child: Text('Confirm',style:
                                TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20
                                ),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
