import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/screens/general/home/home_screen.dart';
import 'package:healtha/screens/patient/lab_analysis/saved_reports.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'drop_file.dart';
import 'generated.dart';
import 'report.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final String _fileName = 'No file chosen';
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          S.of(context).Proactive_health_starts_here,
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: myPurple),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          S.of(context).Unlocking_insights_with_smart_reports,
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.1),
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Text(
                      S.of(context).Upload_your_lab_analysis_results,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FileDropWidget(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      height: .50, // Customize the thickness
                      color: Colors.grey, // Customize the color
                    ),
                    const SizedBox(height: 10.0),
                    if (_isEnabled == false)
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            """Your healtha report is being generated with care...
We will notify you as soon as it is ready
Thank you for allowing us the time to ensure accuracy!""",
                            textStyle: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            speed: const Duration(milliseconds: 40),
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
                    if (showAfterAnimation)
                      Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UploadPage()),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(myPurple),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Text(S.of(context).Generate_another_report),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                S.of(context).or,
                                style: TextStyle(color: myPurple),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                                child: Text(
                                  S.of(context).return_home,
                                  style: TextStyle(
                                      color: myPurple,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
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
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(_isEnabled
                            ? Colors.white
                            : myPurple.withOpacity(0)),
                        backgroundColor: MaterialStateProperty.all(
                            _isEnabled ? myPurple : myPurple.withOpacity(0)),
                      ),
                      child: Text(S.of(context).Generate),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return Stack(
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
                          horizontal: 33,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          S.of(context).Hey_nI_am_here_to_read_the_page_for_you,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            // Adjust font family and style as needed
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
                    onTap: () async {
                      if (isReading) {
                        await flutterTts.stop();
                        setState(() {
                          isReading = false;
                        });
                      } else if (currentIndex == 0) {
                        await _readPage();
                      } else {
                        await _resumeReading();
                      }
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
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
