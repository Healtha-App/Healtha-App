import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _fileName = 'No file chosen';
  bool showAfterAnimation = false;
  bool _isEnabled = true;
  String healthReport = ''; // Variable to store health report data

  int _selectedIndex = 0;
  static const Color myPurple = Color(0xff7c77d1);

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse('https://api.chatpdf.com/v1/chats/message'),
      headers: {
        'x-api-key': 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sourceId': 'src_zGaagrXZbLcNV3hDaVUyR',
        'messages': [
          {
            'role': 'user',
            'content': 'Write a user-friendly lab analysis report about this lab test in this formats '
                'in points and each point list of items, in this report write'
                "start with Dear (patient name from the report), We hope this report finds you in good health. "
                "We have conducted a comprehensive analysis to assess your health. "
                "1. Test name and definition 2. Interpretations about each important value result"
                "3. Medical advices and tips for managing these values to take care of their health"
                "write all under 250 word"
                'after the final warm regards write (Healtha team)',
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        healthReport = json.decode(response.body)['content'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .50,
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
                  bottom: -400,
                  top: 60,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 750,
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
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Your Healtha Report",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            healthReport,
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              // Implement save logic
                            },
                            style: ElevatedButton.styleFrom(
                              primary: myPurple, // Background color
                            ),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                color: Colors.white, // Text color
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                // Implement chatbot logic
                              },
                              child: Text(
                                "Want to get a better understanding? \n"
                                    "Click here to chat with Healthabot",
                                style: TextStyle(
                                  color: myPurple,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
