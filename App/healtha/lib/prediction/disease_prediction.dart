import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

bool isExpanded = false;
bool _isEnabled = true;
bool showAfterAnimation = false;
String predictedDisease = '';
List<String> selectedSymptoms = [];
List<String> symptomsFromServer = [];

class Disease extends StatefulWidget {
  const Disease({Key? key}) : super(key: key);

  @override
  State<Disease> createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  static const Color myPurple = Color(0xff7c77d1);

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });

    // Load symptoms from the server when expanded
    if (isExpanded) {
      _fetchAllSymptoms();
    } else {
      // Clear symptoms when collapsed
      setState(() {
        symptomsFromServer.clear();
      });
    }
  }

  Future<void> _fetchAllSymptoms() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.56.1:5000/all_symptoms'));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> && responseData.containsKey('all_symptoms') && responseData['all_symptoms'] is List) {
          final List<String> symptoms = List<String>.from(responseData['all_symptoms']);

          setState(() {
            symptomsFromServer = symptoms;
          });
        } else {
          print('Invalid response format. "all_symptoms" not found or not a list.');
          print('Response: $responseData');
        }
      } else {
        print('Failed to fetch all symptoms. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }




  Future<void> _predictDisease(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.56.1:5000/predict'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'symptoms': selectedSymptoms}),
      );
      // Print the entire response for debugging
      print('Response: ${response.body}');

      final dynamic jsonResponse = json.decode(response.body);

      if (jsonResponse is String) {
        setState(() {
          predictedDisease = jsonResponse;
        });

        // Display predicted disease in the stream message
        showAfterAnimation = true;
      } else {
        print('Invalid response format from server.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  bool _isSymptomSelected(String symptom) {
    return selectedSymptoms.contains(symptom);
  }

  void _toggleSymptom(String symptom) {
    setState(() {
      if (selectedSymptoms.contains(symptom)) {
        selectedSymptoms.remove(symptom);
      } else {
        selectedSymptoms.add(symptom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myPurple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
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
                  bottom: -50,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: myPurple,
                          offset: Offset(0.0, 2.0),
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
                          "Your health, our priority!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: myPurple,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Disease prediction made easy",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Text(
                    'What are you feeling?',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(12),
                          width: 90,
                          height: 40,
                          child: Image(image: AssetImage("assets/mental-health.png")),
                        ),
                        Text(
                          'Show symptoms',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: myPurple,
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: toggleExpanded,
                            child: Icon(
                              isExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 32.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 9,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                  ),
                  if (isExpanded)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: [
                          for (int i = 0; i < symptomsFromServer.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: CheckboxListTile(
                                value: _isSymptomSelected(symptomsFromServer[i]),
                                onChanged: (bool? value) {
                                  _toggleSymptom(symptomsFromServer[i]);
                                },
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                title: Text(
                                  symptomsFromServer[i],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          Divider(
                            height: 10,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            if (_isEnabled == false)
              Column(
                children: [
                  if (showAfterAnimation)
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          """ The predicted disease is : $predictedDisease
Your health disease report is being generated with care...
                
We will notify you as soon as it is ready

Thank you for allowing us the time to ensure accuracy!""",
                          textStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                          speed: Duration(milliseconds: 40),
                        ),
                      ],
                      isRepeatingAnimation: false,
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true,
                      repeatForever: false,
                      onFinished: () {
                        setState(() {
                          // Do not set showAfterAnimation to true here
                        });
                      },
                    ),
                ],
              ),

            Container(
              width: double.infinity,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _isEnabled
                          ? () {
                        _predictDisease(context);
                        setState(() {
                          _isEnabled = false;
                        });
                      }
                          : null,
                      child: Text('Generate'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.all(_isEnabled ? Colors.white : myPurple.withOpacity(0)),
                        backgroundColor: MaterialStateProperty.all(_isEnabled ? myPurple : myPurple.withOpacity(0)),
                      ),
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
