import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../doctor_ui/doc_signUp.dart';
import '../generated/l10n.dart';
import '../register_login/sign_up.dart';

class joinAs extends StatefulWidget {
  @override
  _JoinAsState createState() => _JoinAsState();
}

class _JoinAsState extends State<joinAs> {
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  bool _isDoctorSelected = true;
  bool _isVolumeHigh = true;
  bool _showDelayedMessage = true;

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
      _speak("Join app as: Doctor or Patient");
    }
    setState(() {
      _isVolumeHigh = !_isVolumeHigh; // Toggle volume state
    });
  }

  void _selectDoctor(BuildContext context) {
    setState(() {
      _isDoctorSelected = true;
    });
    _speak("Doctor");
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => docSignUpPage(),
      ),
    );
  }

  void _selectPatient(BuildContext context) {
    setState(() {
      _isDoctorSelected = false;
    });
    _speak("Patient");
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double imageHeight = screenSize.height * 0.4;
    final double imageWidth = screenSize.width * 0.4;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xff7c77d1).withOpacity(0.5),
              const Color(0xff7c77d1).withOpacity(0.7),
              const Color(0xff7c77d1).withOpacity(0.9),
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: Center(
                child:Container(
                  padding: const EdgeInsets.all(20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xff7c77d1),
                        offset: Offset(0.0, 2.0),
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Join app as .. ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(height: screenSize.height * 0.2),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _selectDoctor(context),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: _isDoctorSelected ? imageWidth * 1.2 : imageWidth,
                          height: _isDoctorSelected ? imageHeight * 1.2 : imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('images/doctor.jpeg'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                              child: Text(
                                "Doctor",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.height * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenSize.width * 0.05),
                      GestureDetector(
                        onTap: () => _selectPatient(context),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          width: !_isDoctorSelected ? imageWidth * 1.2 : imageWidth,
                          height: !_isDoctorSelected ? imageHeight * 1.2 : imageHeight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: AssetImage('images/patient.jpeg'),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.01),
                              child: Text(
                                "Patient",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenSize.height * 0.025,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15),
                                ),
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.05), // Add some space at the bottom
              ],
            ),
          ],
        ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }
}

class DocSignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Sign Up"),
      ),
      body: Center(
        child: Text(
          "Doctor Sign Up Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Sign Up"),
      ),
      body: Center(
        child: Text(
          "Patient Sign Up Page",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
