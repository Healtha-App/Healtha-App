import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/variables.dart';
import 'package:http/http.dart' as http;

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _translatedReport = '';
  bool _isTranslated = false;
  bool _isTranslating = false;
  static const String _apiKey = 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9';

  Future<void> _saveReport(
      int userId, String filePath, String reportContent) async {
    if (_translatedReport.isEmpty) {
      // If translated report is not available yet, wait for translation to complete
      return;
    }

    print(_translatedReport);
    setState(() {
      _isTranslating = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'http://ec2-18-221-98-187.us-east-2.compute.amazonaws.com:4000/api/healtha/reports'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'filePath': filePath,
          'reportContent': _translatedReport,
          'confirmed': false, // Set confirmed to false by default
        }),
      );

      if (response.statusCode == 201) {
        setState(() {
          _isTranslated = true; // Assuming report is saved successfully
          _isTranslating = false;
        });
      } else {
        throw Exception('Failed to save report');
      }
    } catch (error) {
      print('Error saving report: $error');
      setState(() {
        _isTranslating = false;
      });
    }
  }

  Future<void> _translateReport() async {
    setState(() {
      _isTranslating = true;
    });

    String promptWithLanguage =
        _isTranslated ? _getTranslatedPrompt() : _getOriginalPrompt();

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

      // Save the translated report
      _saveReport(1, 'file_path', _translatedReport);
    } else {
      print('Failed to translate report');
      setState(() {
        _isTranslating = false;
      });
    }
  }

  String _getOriginalPrompt() {
    return 'Write a user-friendly lab analysis report about this lab test in this formats '
        'in points and each point list of items, in this report write'
        "start with Dear (patient name from the report), We hope this report finds you in good health. "
        "We have conducted a comprehensive analysis to assess your health. "
        "1. Test name and definition 2. Interpretations about each important value result"
        "3. Medical advices and tips for managing these values to take care of their health"
        "customize the numbered headlines to be suitable for the user"
        "write all under 250 words"
        'after the final warm regards write (Healtha team)'
        'write the whole report';
  }

  String _getTranslatedPrompt() {
    return 'Write a user-friendly lab analysis report about this lab test in this formats '
        'in points and each point list of items, in this report write'
        "start with Dear (patient name from the report), We hope this report finds you in good health. "
        "We have conducted a comprehensive analysis to assess your health. "
        "1. Test name and definition 2. Interpretations about each important value result"
        "3. Medical advices and tips for managing these values to take care of their health"
        "customize the numbered headlines to be suitable for the user"
        "write all under 250 words in arabic language"
        'after the final warm regards write (Healtha team)';
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
    final myPurple = Theme.of(context).colorScheme.secondary;

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
                    Color(0xff7c77d1), // Light blue
                    Color(0xff7c77d1).withOpacity(0.2),
                    Colors.transparent// Light grey
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
                  color: Color(0xff7c77d1), // Purple
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
                  color: Color(0xff7c77d1), // Purple
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
                  color: AppConfig.myPurple, // Purple
                  borderRadius: BorderRadius.circular(screenSize.width * 0.1),
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Center(
              child: Container(

                height: MediaQuery.of(context).size.height * 0.82,
                width: MediaQuery.of(context).size.width * 0.9,

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(15), // Set the radius to make the borders rounded

                ),
                child: Padding(
                  padding: EdgeInsets.all(screenSize.width * 0.05),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Healtha Report",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: myPurple,
                          ),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  _translatedReport ?? '',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: !_isTranslating
                                      ? () {
                                    // Save the report without triggering translation
                                    _saveReport(1, 'file_path', _translatedReport); // Pass report content
                                  }
                                      : null, // Disable button if translation is ongoing
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: AppConfig.myPurple,
                                    minimumSize: Size(screenSize.width * 0.8, 50),
                                  ),
                                  child: Text(
                                    _isTranslated ? "Save" : "حفظ",
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    if (!_isTranslating) {
                                      _translateReport();
                                    }
                                  },
                                  child: Text(
                                    "Translate this report",
                                    style: const TextStyle(
                                      color: Color(0xff7c77d1),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
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
      ),
    );
  }
}
