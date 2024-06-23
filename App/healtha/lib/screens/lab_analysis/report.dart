import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import '../generated/l10n.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _translatedReport = '';
  bool _isTranslated = false;
  bool _isTranslating = false;
  bool _showDelayedMessage = true;
  String _testName = 'Test Name';
  static const String _apiKey = 'sec_CR4fnBuCT0yYpaeD92AfG1BSihAL9Rq9';

  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  bool _isVolumeHigh = true;

  @override
  void initState() {
    super.initState();
    _initTTS();
    _translateReport(); // Initial translation
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showDelayedMessage = false;
        });
      }
    });
  }

  void _initTTS() async {
    List<dynamic> voices = await _flutterTts.getVoices;
    List<Map<String, String>> englishVoices = voices
        .where((voice) => (voice["name"]?.contains("en") ?? false))
        .map((voice) => Map<String, String>.from(voice))
        .toList();

    if (englishVoices.isNotEmpty) {
      await _flutterTts.setVoice(englishVoices.first);
    }

    // Set the speech rate here
    await _flutterTts.setSpeechRate(1.0); // 1.0 is normal speed
  }

  void _speak(String text) async {
    await _flutterTts.speak(text);
    setState(() {
      _isPlaying = true;
    });
  }

  void _stop() async {
    await _flutterTts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _toggleSound() {
    if (_isPlaying) {
      _stop();
    } else {
      _speak(_translatedReport);
    }
    setState(() {
      _isVolumeHigh = !_isVolumeHigh;
    });
  }

  Future<void> _saveReport(
      int userId, String filePath, String reportContent, String testName) async {
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
            'http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'filePath': filePath,
          'reportContent': _translatedReport,
          'confirmed': false, // Set confirmed to false by default
          'testName': testName, // Include the test name
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

    final testNameResponse = await http.post(
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
            'content': 'Write only the name of this test. return the test in this formats:"Complete Blood Count Test',
          }
        ],
      }),
    );

    if (response.statusCode == 200 && testNameResponse.statusCode == 200) {
      setState(() {
        _translatedReport = json.decode(response.body)['content'];
        _testName = json.decode(testNameResponse.body)['content'];
        _isTranslated = true;
        _isTranslating = false;
      });

      // Save the translated report
      _saveReport(1, 'file_path', _translatedReport, _testName);
    } else {
      print('Failed to translate report or get test name');
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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            final bool isLargeScreen = constraints.maxWidth > 600;
            final double fontSize = isLargeScreen ? 18 : 14;
            final double padding = isLargeScreen ? 30 : 20;
            final double buttonWidth = isLargeScreen ? 0.6 : 0.8;

            return Stack(
              children: [
                // Background Gradient
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFE0E7EA), // Light blue
                        const Color(0xff7c77d1).withOpacity(0.2), // Light grey
                      ],
                    ),
                  ),
                ),
                // Abstract Shapes
                Positioned(
                  top: -constraints.maxWidth * 0.3,
                  right: -constraints.maxWidth * 0.1,
                  child: Container(
                    width: constraints.maxWidth * 0.6,
                    height: constraints.maxWidth * 0.6,
                    decoration: BoxDecoration(
                      color: Color(0xff7c77d1), // Purple
                      borderRadius:
                      BorderRadius.circular(constraints.maxWidth * 0.3),
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight * 0.3,
                  left: -constraints.maxWidth * 0.2,
                  child: Container(
                    width: constraints.maxWidth * 0.4,
                    height: constraints.maxWidth * 0.4,
                    decoration: BoxDecoration(
                      color: Color(0xff7c77d1), // Purple
                      borderRadius:
                      BorderRadius.circular(constraints.maxWidth * 0.2),
                    ),
                  ),
                ),
                Positioned(
                  bottom: constraints.maxHeight * 0.01,
                  right: constraints.maxWidth * 0.01,
                  child: Container(
                    width: constraints.maxWidth * 0.2,
                    height: constraints.maxWidth * 0.2,
                    decoration: BoxDecoration(
                      color: Color(0xff7c77d1), // Purple
                      borderRadius:
                      BorderRadius.circular(constraints.maxWidth * 0.1),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: constraints.maxHeight * 0.82,
                        width: constraints.maxWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withOpacity(0.7),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(padding),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  "Healtha Report",
                                  style: TextStyle(
                                    fontSize: fontSize,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff7c77d1),
                                  ),
                                ),
                              ),
                              const Divider(),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(padding),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          _translatedReport,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
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
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: !_isTranslating
                            ? () {
                          // Save the report without triggering translation
                          _saveReport(1, 'file_path', _translatedReport,
                              _testName); // Pass report content
                        }
                            : null, // Disable button if translation is ongoing
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xff7c77d1),
                          minimumSize:
                          Size(constraints.maxWidth * buttonWidth, 50),
                        ),
                        child: Text(
                          _isTranslated ? "Save" : "حفظ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: fontSize,
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
                          style: TextStyle(
                            color: Color(0xff7c77d1),
                            fontSize: fontSize,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.02, // Adjust position based on screen size
              left: MediaQuery.of(context).size.width *
                  0.2, // Adjust position based on screen size
              child: Visibility(
                visible: _showDelayedMessage,
                child: AnimatedOpacity(
                  opacity: _showDelayedMessage ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 33, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      S.of(context).Hey_nI_am_here_to_read_the_page_for_you,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: S.of(context).Roboto, // Example font family
                        fontStyle: FontStyle.italic, // Example style
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height *
                  0.02, // Adjust position based on screen size
              right: 0,
              child: InkWell(
                onTap: () {
                  _toggleSound();
                },
                borderRadius: BorderRadius.circular(28.0),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      _isVolumeHigh
                          ? FontAwesomeIcons.volumeHigh
                          : FontAwesomeIcons.volumeUp,
                      size: 20,
                      color: _isVolumeHigh
                          ? Colors.white
                          : const Color(0xff7c77d1),
                    ),
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
