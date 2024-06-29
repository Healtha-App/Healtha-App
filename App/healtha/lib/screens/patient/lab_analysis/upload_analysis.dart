import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/patient/lab_analysis/saved_reports.dart';
import 'drop_file.dart';
import 'generated.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? _filePath;
  String? _reportContent;
  String _fileName = 'No file chosen';
  final String _processingText = '';
  bool showAfterAnimation = false;
  bool _isEnabled = true;
  bool _showDelayedMessage = true;

  final int _selectedIndex = 0;
  static Color myPurple = const Color(0xff7c77d1);

  String _result = ''; // Add this variable to store the result
  final FlutterTts flutterTts = FlutterTts();

  bool isReading = false;
  int currentIndex = 0;
  String fullText = '';
  bool _isPlaying = false;
  bool _isVolumeHigh = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showDelayedMessage = false;
        });
      }
    });
  }

  void _speak(String text) {
    flutterTts.speak(text);
    setState(() {
      _isPlaying = true;
    });
  }

  void _stop() {
    flutterTts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _toggleSound() {
    if (_isPlaying) {
      _stop();
    } else {
      _speak("Join app as: Doctor or Patient");
    }
    setState(() {
      _isVolumeHigh = !_isVolumeHigh; // Toggle volume state
    });
  }

  Future<void> sendReport(String filePath, String testName, String reportContent) async {
    try {
      final response = await http.post(
        Uri.parse('http://ec2-18-117-114-121.us-east-2.compute.amazonaws.com:4000/api/healtha/reports'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'filePath': filePath,
          'testName': testName,
          'reportContent': reportContent,
        }),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _result = data['result'];
        });
      } else {
        print('Failed to load data');
      }
    } catch (error) {
      print("Error during request: $error");
    }
  }

  Future<void> _readPage() async {
    if (!isReading) {
      String textToRead = """
      ${S.of(context).Proactive_health_starts_here}.
      ${S.of(context).Unlocking_insights_with_smart_reports}.
      ${S.of(context).Upload_your_lab_analysis_results}.
      """;

      if (!_isEnabled) {
        textToRead += """
        Your healtha report is being generated with care...
        We will notify you as soon as it is ready.
        Thank you for allowing us the time to ensure accuracy!
        """;
      }

      fullText = textToRead;

      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);

      flutterTts.setStartHandler(() {
        setState(() {
          isReading = true;
        });
      });

      flutterTts.setCompletionHandler(() {
        setState(() {
          isReading = false;
          currentIndex = 0;
        });
      });

      flutterTts.setCancelHandler(() {
        setState(() {
          isReading = false;
        });
      });

      await flutterTts.speak(fullText.substring(currentIndex));
    } else {
      await flutterTts.stop();
      setState(() {
        isReading = false;
      });
    }
  }

  Future<void> _resumeReading() async {
    if (!isReading) {
      await flutterTts.speak(fullText.substring(currentIndex));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Set the background color to transparent
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
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.surface,
          ),
        ),
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: ListView(
              children: [
                SizedBox(
                  height: 60,
                  child: DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      S.of(context).Your_reports,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.library_books_sharp),
                  title: Text(
                    S.of(context).Generated_Reports,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GeneratedReports()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.bookmark),
                  title: Text(
                    S.of(context).Saved_Reports,
                    style: TextStyle(
                      color: Colors.black, // Adjust text color as needed
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavedReports()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text(
                    S.of(context).History,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SavedReports()),
                    );
                  },
                ),
                // Add more items as needed
              ],
            ),
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
                    borderRadius: const BorderRadius.only(
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
                    padding: const EdgeInsets.all(20),
                    width: screenSize.width * 0.9,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          //color: myPurple.withOpacity(0.5), // Adjust shadow color as needed
                          offset: const Offset(0.0, 2.0),
                          blurRadius: 1.0,
                          spreadRadius: 0.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).Proactive_health_starts_here,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).Unlocking_insights_with_smart_reports,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Expanded(
              child: Center(
                child: FileDropWidget(
                  onFilePicked: (filePath, content) async {
                    setState(() {
                      _filePath = filePath;
                      _reportContent = content;
                      _fileName = filePath.split('/').last;
                    });

                    // Call sendReport method with testName and reportContent when file is picked
                    await sendReport(
                      _filePath!,
                      'Sample Test Name',
                      _reportContent!,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              _fileName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isEnabled
                  ? () async {
                setState(() {
                  _isEnabled = false;
                });

                await _readPage();

                await Future.delayed(const Duration(seconds: 5));

                // Simulate sending a report with a delay for demonstration
                await sendReport(
                  _filePath!,
                  'Sample Test Name',
                  _reportContent!,
                );

                setState(() {
                  _isEnabled = true;
                });
              }
                  : null,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(myPurple),
              ),
              child: Text(
                S.of(context).Generate_Laboratory_Test_Report,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _result, // Display the result received from the API
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: _toggleSound,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _isVolumeHigh ? myPurple : Colors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _isPlaying ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isPlaying ? 'Stop Sound' : 'Play Sound',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
