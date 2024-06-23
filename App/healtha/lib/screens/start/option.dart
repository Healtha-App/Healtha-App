import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtha/screens/encyclopedias/encyclopedia_types.dart';
import 'package:healtha/screens/generated/l10n.dart';
import 'package:healtha/screens/register_login/join_as.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icon.dart';

class option extends StatefulWidget {
  const option({super.key});

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
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _initTTS();

    // Display the delayed message initially
    _showDelayedMessage = true;

    // Delayed hide of the message after 10 seconds
    Future.delayed(const Duration(seconds: 10), () {
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
    const text =
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
                const Color(0xff7c77d1).withOpacity(0.5),
                const Color(0xff7c77d1).withOpacity(0.7),
                const Color(0xff7c77d1).withOpacity(0.9),
                const Color(0xff7c77d1),
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
                    top: MediaQuery.of(context).size.height *
                        (1 - _animation.value),
                    left: MediaQuery.of(context).size.width *
                        (1 - _animation.value),
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.1,
                    ),
                    Row(
                      children: [
                        Text(
                          S
                              .of(context)
                              .Step_into_a_world_of_holistic_nhealth_with,
                          //"Step into a world of holistic\nhealth with",
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
                          S.of(context).nHealtha,
                          // " \nHealtha",
                          style: GoogleFonts.dancingScript(
                            textStyle: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height:MediaQuery.of(context).size.height * 0.5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EncyclopediaTypes()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Colors.white, // Change border color here
                            ), // Remove border
                          ),
                        ),
                        child: SizedBox(
                          width: 300,
                          child: Center(
                            child: Text(
                              S.of(context).Show_encyclopedia,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                      MediaQuery.of(context).size.height * 0.02,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const joinAs()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Colors.white, // Change border color here
                            ), // Remove border
                          ),
                        ),
                        child: SizedBox(
                          width: 300,
                          child: Center(
                            child: Text(
                              S.of(context).Start_using_app,
                              style: const TextStyle(
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
            top: MediaQuery.of(context).size.height *
                0.02,// Adjust this position as needed
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
            top: MediaQuery.of(context).size.height *
                0.02, // Adjust this position as needed
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
