import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/register_login/join_as.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome package

class option extends StatefulWidget {
  @override
  _OptionState createState() => _OptionState();
}

class _OptionState extends State<option> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isPlaying = false;
  bool _showDelayedMessage = false;
  bool _isVolumeHigh = true; // New state variable for icon state

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _initTTS();

    // Display the delayed message initially
    _showDelayedMessage = true;

    // Delayed hide of the message after 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          _showDelayedMessage = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _initTTS() {
    _flutterTts.getVoices.then((data) {
      try {
        List<Map<String, String>> voices =
        List<Map<String, String>>.from(data);
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
    final text =
        "Step into a world of holistic health with Healtha. Show encyclopedia. Start using app.";
    _speak(text);
  }

  void _toggleIcon() {
    setState(() {
      _isVolumeHigh = !_isVolumeHigh;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff7c77d1).withOpacity(0.5),
                Color(0xff7c77d1).withOpacity(0.7),
                Color(0xff7c77d1).withOpacity(0.9),
                Color(0xff7c77d1),
              ],
            ),
          ),
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    top: MediaQuery.of(context).size.height * _animation.value,
                    left: MediaQuery.of(context).size.width * _animation.value,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  );
                },
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Positioned(
                    top: MediaQuery.of(context).size.height * (1 - _animation.value),
                    left: MediaQuery.of(context).size.width * (1 - _animation.value),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    Row(
                      children: [
                        Text(
                          "Step into a world of holistic\nhealth with",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          " \nHealtha",
                          style: GoogleFonts.dancingScript(
                            textStyle: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 250,
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EncyclopediaTypes()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: Colors.white, // Change border color here
                            ), // Remove border
                          ),
                        ),
                        child: SizedBox(
                          width: 300,
                          child: Center(
                            child: Text(
                              'Show encyclopedia',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 400,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => joinAs()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                              color: Colors.white, // Change border color here
                            ), // Remove border
                          ),
                        ),
                        child: SizedBox(
                          width: 300,
                          child: Center(
                            child: Text(
                              'Start using app',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
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
                duration: Duration(milliseconds: 500),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Hey! \nI am here to read the page for you',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'Roboto', // Example font family
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
                    _isVolumeHigh ? FontAwesomeIcons.volumeHigh : FontAwesomeIcons.volumeUp,
                    size: 20,
                    color: _isVolumeHigh ? Colors.white : Color(0xff7c77d1),
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
