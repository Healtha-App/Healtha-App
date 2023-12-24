import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'drop_file.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String _fileName = 'No file chosen';
  String _processingText = '';
  bool showAfterAnimation= false;
  bool _isEnabled = true;

  int _selectedIndex = 0;
  static const Color myPurple = Color(0xff7c77d1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
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
                  bottom: -50,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
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
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.1),
              child: Column(
                children: [
                  SizedBox(height: 30.0),
                  Text(
                    'Upload your lab analysis results',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FileDropWidget(),
      
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ElevatedButton.icon(
                  //       onPressed: () async {
                  //         var pickedFile = await FilePicker.platform.pickFiles();
                  //
                  //         if (pickedFile != null) {
                  //           setState(() {
                  //             _fileName =
                  //                 pickedFile.files.first.name ?? 'No file chosen';
                  //           });
                  //         }
                  //       },
                  //       icon: Icon(Icons.upload),
                  //       label: Text('Choose File'),
                  //       style: ButtonStyle(
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.white),
                  //         foregroundColor:
                  //             MaterialStateProperty.all<Color>(myPurple),
                  //         side: MaterialStateProperty.all<BorderSide>(
                  //           BorderSide(color: myPurple, width: 1.0),
                  //         ),
                  //         shape:
                  //             MaterialStateProperty.all<RoundedRectangleBorder>(
                  //           RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.0),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 40,
                  //     ),
                  //     Text(
                  //       _fileName,
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 10,),
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
                        // textStyle: TextStyle(fontSize: 30.0),
                        speed: Duration(milliseconds: 40),
                      ),
                    ],
                      isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                      //pause: const Duration(milliseconds: 500),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      repeatForever: false,
                      onFinished: () {
                        setState(() {
                          // Update state to show the widget after finishing the animation
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
                      //foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
    );
  }


}
