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
String predictionResult = '';
List<String> selectedSymptomNames = [];
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

// Create a mapping of symptoms to indices (zero-based)
  Map<String, int> symptomsMapping = {
    "itching": 0,
    "skin_rash": 1,
    "nodal_skin_eruptions": 2,
    "continuous_sneezing": 3,
    "shivering": 4,
    "chills": 5,
    "joint_pain": 6,
    "stomach_pain": 7,
    "acidity": 8,
    "ulcers_on_tongue": 9,
    "muscle_wasting": 10,
    "vomiting": 11,
    "burning_micturition": 12,
    "spotting_ urination": 13,
    "fatigue": 14,
    "weight_gain": 15,
    "anxiety": 16,
    "cold_hands_and_feets": 17,
    "mood_swings": 18,
    "weight_loss": 19,
    "restlessness": 20,
    "lethargy": 21,
    "patches_in_throat": 22,
    "irregular_sugar_level": 23,
    "cough": 24,
    "high_fever": 25,
    "sunken_eyes": 26,
    "breathlessness": 27,
    "sweating": 28,
    "dehydration": 29,
    "indigestion": 30,
    "headache": 31,
    "yellowish_skin": 32,
    "dark_urine": 33,
    "nausea": 34,
    "loss_of_appetite": 35,
    "pain_behind_the_eyes": 36,
    "back_pain": 37,
    "constipation": 38,
    "abdominal_pain": 39,
    "diarrhoea": 40,
    "mild_fever": 41,
    "yellow_urine": 42,
    "yellowing_of_eyes": 43,
    "acute_liver_failure": 44,
    "fluid_overload": 45,
    "swelling_of_stomach": 46,
    "swelled_lymph_nodes": 47,
    "malaise": 48,
    "blurred_and_distorted_vision": 49,
    "phlegm": 50,
    "throat_irritation": 51,
    "redness_of_eyes": 52,
    "sinus_pressure": 53,
    "runny_nose": 54,
    "congestion": 55,
    "chest_pain": 56,
    "weakness_in_limbs": 57,
    "fast_heart_rate": 58,
    "pain_during_bowel_movements": 59,
    "pain_in_anal_region": 60,
    "bloody_stool": 61,
    "irritation_in_anus": 62,
    "neck_pain": 63,
    "dizziness": 64,
    "cramps": 65,
    "bruising": 66,
    "obesity": 67,
    "swollen_legs": 68,
    "swollen_blood_vessels": 69,
    "puffy_face_and_eyes": 70,
    "enlarged_thyroid": 71,
    "brittle_nails": 72,
    "swollen_extremities": 73,
    "excessive_hunger": 74,
    "extra_marital_contacts": 75,
    "drying_and_tingling_lips": 76,
    "slurred_speech": 77,
    "knee_pain": 78,
    "hip_joint_pain": 79,
    "muscle_weakness": 80,
    "stiff_neck": 81,
    "swelling_joints": 82,
    "movement_stiffness": 83,
    "spinning_movements": 84,
    "loss_of_balance": 85,
    "unsteadiness": 86,
    "weakness_of_one_body_side": 87,
    "loss_of_smell": 88,
    "bladder_discomfort": 89,
    "foul_smell_of_urine": 90,
    "continuous_feel_of_urine": 91,
    "passage_of_gases": 92,
    "internal_itching": 93,
    "toxic_look_(typhos)": 94,
    "depression": 95,
    "irritability": 96,
    "muscle_pain": 97,
    "altered_sensorium ": 98,
    "red_spots_over_body": 99,
    "belly_pain": 100,
    "abnormal_menstruation": 101,
    "dischromic_patches": 102,
    "watering_from_eyes": 103,
    "increased_appetite": 104,
    "polyuria": 105,
    "family_history": 106,
    "mucoid_sputum": 107,
    "rusty_sputum": 108,
    "lack_of_concentration": 109,
    "visual_disturbances": 110,
    "receiving_blood_transfusion": 111,
    "receiving_unsterile_injections": 112,
    "coma": 113,
    "stomach_bleeding": 114,
    "distention_of_abdomen": 115,
    "history_of_alcohol_consumption": 116,
    "fluid_overload": 117,
    "blood_in_sputum": 118,
    "prominent_veins_on_calf": 119,
    "palpitations": 120,
    "painful_walking": 121,
    "Pus_filled_pimples": 122,
    "blackheads": 123,
    "scurring": 124,
    "skin_peeling": 125,
    "Silver_like_dusting": 126,
    "small_dents_in_nails": 127,
    "inflammatory_nails": 128,
    "blister": 129,
    "red_sore_around_nose": 130,
    "yellow_crust_ooze": 131,
  };


  Future<void> _predictDisease(BuildContext context) async {
    try {
      List<int> symptomsInput = List<int>.filled(132, 0);

      for (int i = 0; i < symptomsFromServer.length; i++) {
        if (_isSymptomSelected(symptomsFromServer[i])) {
          symptomsInput[i] = 1;
        }
      }

      // Print the selected symptoms for testing
      print('Selected symptoms: $symptomsInput');

      final response = await http.post(
        Uri.parse('http://192.168.56.1:5000/predict'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({'symptoms': symptomsInput}),
      );

      // Print the entire response for debugging
      print('Response: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse is Map<String, dynamic> &&
            jsonResponse.containsKey('prediction')) {
          final dynamic predictionData = jsonResponse['prediction'];

          if (predictionData is String) {
            setState(() {
              predictedDisease = predictionData;
            });

            // Display predicted disease in the stream message
            showAfterAnimation = true;
          } else {
            print('Invalid prediction format from server.');
          }
        } else {
          print('Invalid response format from server. "prediction" key not found.');
        }
      } else {
        print('Failed to predict disease. Status code: ${response.statusCode}');
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
        selectedSymptomNames.remove(symptomsMapping.keys.elementAt(symptomsMapping.values.toList().indexOf(symptomsMapping[symptom]!)));
      } else {
        selectedSymptoms.add(symptom);
        selectedSymptomNames.add(symptomsMapping.keys.elementAt(symptomsMapping.values.toList().indexOf(symptomsMapping[symptom]! )));
      }
    });
  }
  void printSelectedSymptoms() {
    print('Selected Symptoms: $selectedSymptomNames');
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
                            printSelectedSymptoms(); // Print selected symptoms when animation finishes
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
