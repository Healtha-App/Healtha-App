import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healtha/register_login/sign_up.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _translatedReport = '';
  bool _isTranslated = false;
  bool _isTranslating = false;
  static const String _apiKey = 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9';

  Future<void> _translateReport() async {
    setState(() {
      _isTranslating = true;
    });

    String promptWithLanguage = _isTranslated
        ? 'Write a user-friendly lab analysis report about this lab test in this formats '
        'in points and each point list of items, in this report write'
        "start with Dear (patient name from the report), We hope this report finds you in good health. "
        "We have conducted a comprehensive analysis to assess your health. "
        "1. Test name and definition 2. Interpretations about each important value result"
        "3. Medical advices and tips for managing these values to take care of their health"
        "write all under 250 words"
        'after the final warm regards write (Healtha team)'
        : 'Write a user-friendly lab analysis report about this lab test in this formats '
        'in points and each point list of items, in this report write'
        "start with Dear (patient name from the report), We hope this report finds you in good health. "
        "We have conducted a comprehensive analysis to assess your health. "
        "1. Test name and definition 2. Interpretations about each important value result"
        "3. Medical advices and tips for managing these values to take care of their health"
        "write all under 250 words"
        'after the final warm regards write (Healtha team)'
        'write the whole report in Arabic language';

    final response = await http.post(
      Uri.parse('https://api.chatpdf.com/v1/chats/message'),
      headers: {
        'x-api-key': _apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sourceId': 'src_zGaagrXZbLcNV3hDaVUyR',
        'messages': [
          {
            'role': 'user',
            'content': promptWithLanguage,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        _translatedReport = json.decode(response.body)['content'];
        _isTranslated = !_isTranslated;
        _isTranslating = false;
      });
    } else {
      throw Exception('Failed to translate report');
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch initial report data
    _translateReport();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
              padding: EdgeInsets.all(screenSize.width * 0.05),
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              "Healtha Report",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff7c77d1),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(20),
                            //  decoration: BoxDecoration(
                            // color: Colors.grey[200],
                            //   borderRadius: BorderRadius.circular(15),
                            //),
                            child: Text(
                              _translatedReport ?? '',
                              style: TextStyle(fontSize: 14,),
                            ),
                          ),
                          SizedBox(height: 10,),
                          ElevatedButton(
                            onPressed: () {
                              if (!_isTranslating) {
                                // Save the report without triggering translation
                                // Replace `patientId` with the actual patient ID
                                postReport(patientId!, _translatedReport ?? '');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: _isTranslating ? Colors.grey : Colors.white, backgroundColor: Color(0xFF7C77D1),
                              minimumSize: Size(screenSize.width * 0.8, 50), // Adjust button width and height
                            ),
                            child: _isTranslating
                                ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                                : Text(
                              _isTranslated ? "حفظ" : "Save",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              if (!_isTranslating) {
                                _translateReport();
                              }
                            },
                            child: Text(
                              "Translate to ${_isTranslated ? 'English' : 'Arabic'}",
                              style: TextStyle(
                                color: Color(0xff7c77d1),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),

                        ],

                      ),
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

// Function to post the report
Future<void> postReport(int userID, String content) async {
  const String postReportUrl = 'http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:4000/api/healtha/reports';

  try {
    final response = await http.post(
      Uri.parse(postReportUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userid': userID,
        'content': content,
      }),
    );

    if (response.statusCode == 201) {
      // Report successfully posted
      print('Report successfully posted');
    } else {
      // Handle errors here
      print('Failed to post report. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (error) {
    print('Error posting report: $error');
  }
}
