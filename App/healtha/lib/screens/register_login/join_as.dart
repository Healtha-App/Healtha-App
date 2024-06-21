import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/register_login/sign_up.dart';
import '../doctor_ui/doc_signUp.dart';

class joinAs extends StatefulWidget {
  const joinAs({super.key});

  @override
  _JoinAsState createState() => _JoinAsState();
}

class _JoinAsState extends State<joinAs> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  bool _showDelayedMessage = true;
  bool _isVolumeHigh = true;

  @override
  void initState() {
    super.initState();
    _initTTS();
    Future.delayed(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showDelayedMessage = false;
        });
      }
    });
  }

  void _initTTS() {
    _flutterTts.getVoices.then((data) {
      try {
        List<Map<String, String>> voices = List<Map<String, String>>.from(data);
        List<Map<String, String>> englishVoices = voices
            .where((voice) => voice["name"]?.contains("en") ?? false)
            .toList();
        if (englishVoices.isNotEmpty) {
          _flutterTts.setVoice(englishVoices.first);
        }
      } catch (e) {
        print(e);
      }
    });
  }

  void _speak(String text) {
    _flutterTts.speak(text);
    setState(() {
      _isPlaying = true;
    });
  }

  void _stop() {
    _flutterTts.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _toggleSound() {
    if (_isPlaying) {
      _stop();
    } else {
      _speakAllText();
    }
    _toggleIcon();
  }

  void _speakAllText() {
    const text = "Join as: Doctor or Patient";
    _speak(text);
  }

  void _toggleIcon() {
    setState(() {
      _isVolumeHigh = !_isVolumeHigh;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff7c77d1).withOpacity(0.5),
                const Color(0xff7c77d1).withOpacity(0.7),
                const Color(0xff7c77d1).withOpacity(0.9),
                const Color(0xff7c77d1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: screenSize.height * 0.1),
              Text(
                S.of(context).Join_as,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: screenSize.width * 0.08,
               //   color: Colors.white,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              Container(
                height: screenSize.height * 0.7,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(screenSize.width * 0.1),
                    topRight: Radius.circular(screenSize.width * 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: screenSize.height * 0.1),
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.03),
                      child: InkWell(
                        onTap: () {
                          _speak(S.of(context).Doctor);
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const docSignUpPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenSize.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.width * 0.03)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: screenSize.width * 0.018,
                                offset: Offset(
                                    0,
                                    screenSize.width *
                                        0.025), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).Doctor,
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.06,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: screenSize.width * 0.1),
                              SizedBox(
                                width: screenSize.width * 0.4,
                                height: screenSize.height * 0.2,
                                child: const Image(
                                    image: AssetImage("images/doc.jpg")),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(screenSize.width * 0.03),
                      child: InkWell(
                        onTap: () {
                          _speak("Patient");
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: screenSize.height * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                                Radius.circular(screenSize.width * 0.03)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                blurRadius: screenSize.width * 0.018,
                                offset: Offset(
                                    0,
                                    screenSize.width *
                                        0.025), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: screenSize.width * 0.4,
                                height: screenSize.height * 0.2,
                                child: const Image(
                                    image: AssetImage("images/patient.jpg")),
                              ),
                              SizedBox(width: screenSize.width * 0.1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    S.of(context).Patient,
                                    style: TextStyle(
                                      fontSize: screenSize.width * 0.06,
                                      fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            top: 10, // Adjust this position as needed
            left: 120, // Adjust this position as needed
            child: Visibility(
              visible: _showDelayedMessage,
              child: AnimatedOpacity(
                opacity: _showDelayedMessage ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            top: 10, // Adjust this position as needed
            right: 0, // Adjust this position as needed
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
                    color:
                        _isVolumeHigh ? Colors.white : const Color(0xff7c77d1),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
