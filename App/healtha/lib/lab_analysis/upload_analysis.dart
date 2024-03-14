import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'drop_file.dart';
import 'generated.dart';
import 'report.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _fileName = 'No file chosen';
  String _processingText = '';
  bool showAfterAnimation = false;
  bool _isEnabled = true;

  int _selectedIndex = 0;
  static const Color myPurple = Color(0xff7c77d1);

  String _result = ''; // Add this variable to store the result

  Future<void> fetchData() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:5000/get_analysis'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{}),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        // Parse and use the response
        final data = json.decode(response.body);
        setState(() {
          _result = data['result'];
        });
      } else {
        // Handle errors
        print('Failed to load data');
      }
    } catch (error) {
      print("Error during request: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,

          elevation: 0,// Set the background color to transparent
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  myPurple.withOpacity(0.5),
                  myPurple.withOpacity(0.7),
                  myPurple.withOpacity(0.9),
                  myPurple,
                ],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
          ),

        ),
        drawer: Drawer(
          child: ListView(
          //  padding: EdgeInsets.zero,
            children: [
              DrawerHeader(

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      myPurple.withOpacity(0.5),
                      myPurple.withOpacity(0.7),
                      myPurple.withOpacity(0.9),
                      myPurple,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                  ),
                ),
                child: Center(child: Text('Your reports',style: TextStyle(color: Colors.white,fontSize: 20),)),

              ),
              ListTile(
                title: Text('Generated Reports'),
                onTap: () {
                  // Navigate to the GeneratedReport class when the item is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeneratedReports()),
                  );
                },
              ),
              ListTile(
                title: Text('Saved Reports'),
                onTap: () {
                  // Navigate to the GeneratedReport class when the item is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeneratedReports()),
                  );
                },
              ),
              ListTile(
                title: Text('History'),
                onTap: () {
                  // Navigate to the GeneratedReport class when the item is tapped
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GeneratedReports()),
                  );
                },
              ),
              // Add more items as needed
            ],
          ),
        ),

        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [

                Container(
                  height: screenSize.height * 0.2,
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        myPurple.withOpacity(0.5),
                        myPurple.withOpacity(0.7),
                        myPurple.withOpacity(0.9),
                        myPurple,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                ),

                Positioned(
                  bottom: -50,
                  left: screenSize.width * 0.05,
                  right: screenSize.width * 0.05,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: screenSize.width * 0.9,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: myPurple,
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
            Padding(
              padding: EdgeInsets.all(screenSize.width * 0.1),
              child: Column(
                children: [
                  SizedBox(height: 20.0),
                  Text(
                    'Upload your lab analysis results',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FileDropWidget(),
                  SizedBox(height: 20,),
                  Divider(
                    height: .50, // Customize the thickness
                    color: Colors.grey, // Customize the color
                  ),
                  SizedBox(height: 10.0),
                  if (_isEnabled == false)
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          """Your healtha report is being generated with care...
We will notify you as soon as it is ready
Thank you for allowing us the time to ensure accuracy!""",
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          speed: Duration(milliseconds: 40),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      repeatForever: false,
                      onFinished: () {
                        setState(() {
                          showAfterAnimation = true;
                        });
                      },
                    ),
                  if(showAfterAnimation)
                    Column(
                      children: [
                        SizedBox(height: 10,),
                        ElevatedButton(
                          onPressed: _isEnabled
                              ? () {
                            setState(() {
                              _isEnabled = false;
                            });
                          }
                              : null,
                          child: Text('Generate another report'),
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(myPurple),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(' or '),
                            Text('return home',style: TextStyle(fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                  ElevatedButton(
                    onPressed: _isEnabled
                        ? () {
                      setState(() {
                        _isEnabled = false;
                      });
                    }
                        : null,
                    child: Text('Generate'),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      foregroundColor: MaterialStateProperty.all(
                          _isEnabled ? Colors.white : myPurple.withOpacity(0)),
                      backgroundColor: MaterialStateProperty.all(
                          _isEnabled ? myPurple : myPurple.withOpacity(0)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


