import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healtha/register_login/sign_up.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _fileName = 'No file chosen';
  bool showAfterAnimation = false;
  bool _isEnabled = true;
  String healthReport = '';
  String translatedReport = '';
  bool isTranslated = false;
  bool _isTranslating = false;

  int _selectedIndex = 0;
  static const Color myPurple = Color(0xff7c77d1);
  static const String apiKey = 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9';

  // API endpoint for posting reports
  static const String postReportUrl = 'http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:4000/api/healtha/reports';

  Future<void> fetchData(String prompt) async {
    final response = await http.post(
      Uri.parse('https://api.chatpdf.com/v1/chats/message'),
      headers: {
        'x-api-key': apiKey,
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'sourceId': 'src_zGaagrXZbLcNV3hDaVUyR',
        'messages': [
          {
            'role': 'user',
            'content': prompt,
          }
        ],
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        healthReport = json.decode(response.body)['content'];
        translatedReport = healthReport;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> translateReport() async {
    setState(() {
      _isTranslating = true;
    });

    String promptWithLanguage = isTranslated
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

    await fetchData(promptWithLanguage);

    setState(() {
      isTranslated = !isTranslated;
      _isTranslating = false;
    });
  }

  Future<void> postReport(int userID, String content) async {
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

  @override
  void initState() {
    super.initState();
    fetchData(
      'Write a user-friendly lab analysis report about this lab test in this formats '
          'in points and each point list of items, in this report write'
          "start with Dear (patient name from the report), We hope this report finds you in good health. "
          "We have conducted a comprehensive analysis to assess your health. "
          "1. Test name and definition 2. Interpretations about each important value result"
          "3. Medical advices and tips for managing these values to take care of their health"
          "write all under 250 words"
          'after the final warm regards write (Healtha team)'
      ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Your Healtha Report",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: myPurple,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    translatedReport ?? '',
                    style: TextStyle(fontSize: 14,),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ElevatedButton(
                onPressed: () {
                  if (!_isTranslating) {
                    // Save the report without triggering translation
                    postReport(patientId!, translatedReport ?? '');
                    // Don't translate on save, only save the report
                    // translateReport();
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: _isTranslating ? Colors.grey : Colors.white, backgroundColor: myPurple,
                ),
                child: _isTranslating
                    ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                    : Text(
                  isTranslated ? "حفظ" : "Save",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  if (!_isTranslating) {
                    translateReport();
                  }
                },
                child: Text(
                  "Translate to ${isTranslated ? 'English' : 'Arabic'}",
                  style: TextStyle(
                    color: myPurple,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
