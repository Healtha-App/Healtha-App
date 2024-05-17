import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Disease extends StatefulWidget {
  const Disease({Key? key}) : super(key: key);

  @override
  State<Disease> createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  static const Color myPurple = Color(0xff7c77d1);

  bool isExpanded = false;
  Map<String, List<String>> symptomsCategories = {
    'Dermatological Symptoms': [
      "itching",
      "skin_rash",
      "nodal_skin_eruptions",
      "patches_in_throat",
      "sweating",
      "dehydration",
      "yellowish_skin",
      "bruising",
      "drying_and_tingling_lips",
      "toxic_look_(typhos)",
      "red_spots_over_body",
      "dischromic_patches",
      "Pus_filled_pimples",
      "blackheads",
      "skin_peeling",
      "Silver_like_dusting",
      "blister",
      "red_sore_around_nose",
      "yellow_crust_ooze",
    ],
    'Musculoskeletal Symptoms': [
      "inflammatory_nails",
      "small_dents_in_nails",
      "scurring",
      "painful_walking",
      "prominent_veins_on_calf",
      "muscle_pain",
      "movement_stiffness",
      "swelling_joints",
      "stiff_neck",
      "muscle_weakness",
      "hip_joint_pain",
      "knee_pain",
      "swollen_extremities",
      "brittle_nails",
      "neck_pain",
      "weakness_in_limbs",
      "back_pain",
      "cold_hands_and_feet",
      "muscle_wasting",
      "joint_pain",
      "swollen_legs",
    ],
    'Neurological Symptoms': [
      "Chills",
      "Shivering",
      "Headache",
      "Dizziness",
      "Cramps",
      "Slurred speech",
      "Loss of balance",
      "Unsteadiness",
      "Weakness of one body side",
      "Altered sensorium",
      "Coma",
    ],
    'Gastrointestinal Symptoms': [
      "Acidity",
      "Ulcers on tongue",
      "Vomiting",
      "Indigestion",
      "Nausea",
      "Constipation",
      "Abdominal pain",
      "Diarrhea",
      "Swelling of stomach",
      "Pain during bowel movements",
      "Pain in anal region",
      "Bloody stool",
      "Irritation in anus",
      "Passage of gases",
      "Belly pain",
      "Abnormal menstruation",
      "Stomach bleeding",
      "Distention of abdomen",
      "Stomach pain",
    ],
    'Respiratory Symptoms': [
      "continuous sneezing",
      "cough",
      "Breathlessness",
      "Phlegm",
      "Throat irritation",
      "redness of eyes",
      "sinus pressure",
      "runny nose",
      "congestion",
      "mucoid sputum",
      "rusty sputum",
      "blood in sputum",
    ],
    'Emotional Symptoms': [
      "Lack of concentration",
      "Irritability",
      "Depression",
      "Lethargy",
      "Restlessness",
      "Mood swings",
      "Anxiety",
    ],
    'Urinary Symptoms': [
      "Burning micturition",
      "spotting urination",
      "dark urine",
      "yellow urine",
      "bladder discomfort",
      "foul smell of urine",
      "continuous feel of urine",
      "polyuria",
    ],
    'Cardiovascular Symptoms': [
      "Palpitations",
      "Enlarged thyroid",
      "Swollen blood vessels",
      "Fast heart rate",
      "chest pain",
      "swelled lymph nodes",
    ],
    'Physical Symptoms': [
      "Fatigue",
      "Weight gain",
      "Weight loss",
      "Irregular sugar level",
      "High fever",
      "Sunken eyes",
      "Loss of appetite",
      "Mild fever",
      "Yellowing of eyes",
      "Acute liver failure",
      "Fluid overload",
      "malaise",
      "Obesity",
      "Puffy face and eyes",
      "Extra marital contacts",
      "Spinning movements",
      "Internal itching",
      "Watering from eyes",
      "Family history",
      "Fluid overload",
    ],
    'General Symptoms': [
      "History of alcohol consumption",
      "Receiving unsterile injections",
      "receiving blood transfusion",
    ],
    'Sensory Symptoms': [
      "pain behind the eyes",
      "blurred and distorted vision",
      "excessive hunger",
      "loss of smell",
      "increased appetite",
      "visual disturbances",
    ],
  };

  List<String> selectedSymptoms = [];
  List<String> symptomsFromServer = [];

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
      // Simulate fetching symptoms from the server
      // Replace the URL with the actual endpoint to fetch symptoms
      final response =
      await http.get(Uri.parse('http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:5000/all_symptoms'));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('all_symptoms') &&
            responseData['all_symptoms'] is List) {
          final List<String> symptoms =
          List<String>.from(responseData['all_symptoms']);

          setState(() {
            symptomsFromServer = symptoms;
          });
        } else {
          print(
              'Invalid response format. "all_symptoms" not found or not a list.');
          print('Response: $responseData');
        }
      } else {
        print(
            'Failed to fetch all symptoms. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
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

  String predictedDisease = 'predicted'; // New variable to hold the predicted disease

  Map<String, int> symptomsMapping = {
    "itching": 0,
    "skin_rash": 1,
    "nodal_skin_eruptions": 2,
    "patches_in_throat": 3,
    "sweating": 4,
    "dehydration": 5,
    "yellowish_skin": 6,
    "bruising": 7,
    "drying_and_tingling_lips": 8,
    "toxic_look_(typhos)": 9,
    "red_spots_over_body": 10,
    "dischromic_patches": 11,
    "Pus_filled_pimples": 12,
    "blackheads": 13,
    "skin_peeling": 14,
    "Silver_like_dusting": 15,
    "blister": 16,
    "red_sore_around_nose": 17,
    "yellow_crust_ooze": 18,
    "inflammatory_nails": 19,
    "small_dents_in_nails": 20,
    "scurring": 21,
    "painful_walking": 22,
    "prominent_veins_on_calf": 23,
    "muscle_pain": 24,
    "movement_stiffness": 25,
    "swelling_joints": 26,
    "stiff_neck": 27,
    "muscle_weakness": 28,
    "hip_joint_pain": 29,
    "knee_pain": 30,
    "swollen_extremities": 31,
    "brittle_nails": 32,
    "neck_pain": 33,
    "weakness_in_limbs": 34,
    "back_pain": 35,
    "cold_hands_and_feets": 36,
    "muscle_wasting": 37,
    "joint_pain": 38,
    "swollen_legs": 39,
    "chills": 40,
    "shivering": 41,
    "headache": 42,
    "dizziness": 43,
    "cramps": 44,
    "slurred_speech": 45,
    "loss_of_balance": 46,
    "unsteadiness": 47,
    "weakness_of_one_body_side": 48,
    "altered_sensorium": 49,
    "coma": 50,
    "acidity": 51,
    "ulcers_on_tongue": 52,
    "vomiting": 53,
    "indigestion": 54,
    "nausea": 55,
    "constipation": 56,
    "abdominal_pain": 57,
    "diarrhea": 58,
    "swelling_of_stomach": 59,
    "pain_during_bowel_movements": 60,
    "pain_in_anal_region": 61,
    "bloody_stool": 62,
    "irritation_in_anus": 63,
    "passage_of_gases": 64,
    "belly_pain": 65,
    "abnormal_menstruation": 66,
    "stomach_bleeding": 67,
    "distention_of_abdomen": 68,
    "stomach_pain": 69,
    "continuous_sneezing": 70,
    "cough": 71,
    "Breathlessness": 72,
    "Phlegm": 73,
    "Throat_irritation": 74,
    "redness_of_eyes": 75,
    "sinus_pressure": 76,
    "runny_nose": 77,
    "congestion": 78,
    "mucoid_sputum": 79,
    "rusty_sputum": 80,
    "blood_in_sputum": 81,
    "lack_of_concentration": 82,
    "irritability": 83,
    "depression": 84,
    "lethargy": 85,
    "restlessness": 86,
    "mood_swings": 87,
    "anxiety": 88,
    "burning_micturition": 89,
    "spotting_urination": 90,
    "dark_urine": 91,
    "yellow_urine": 92,
    "bladder_discomfort": 93,
    "foul_smell_of_urine": 94,
    "continuous_feel_of_urine": 95,
    "polyuria": 96,
    "palpitations": 97,
    "enlarged_thyroid": 98,
    "swollen_blood_vessels": 99,
    "fast_heart_rate": 100,
    "chest_pain": 101,
    "swelled_lymph_nodes": 102,
    "fatigue": 103,
    "weight_gain": 104,
    "weight_loss": 105,
    "irregular_sugar_level": 106,
    "high_fever": 107,
    "sunken_eyes": 108,
    "loss_of_appetite": 109,
    "mild_fever": 110,
    "yellowing_of_eyes": 111,
    "acute_liver_failure": 112,
    "fluid_overload": 113,
    "malaise": 114,
    "obesity": 115,
    "puffy_face_and_eyes": 116,
    "extra_marital_contacts": 117,
    "spinning_movements": 118,
    "internal_itching": 119,
    "watering_from_eyes": 120,
    "family_history": 121,
    "history_of_alcohol_consumption": 122,
    "receiving_unsterile_injections": 123,
    "receiving_blood_transfusion": 124,
    "pain_behind_the_eyes": 125,
    "blurred_and_distorted_vision": 126,
    "excessive_hunger": 127,
    "loss_of_smell": 128,
    "increased_appetite": 129,
    "visual_disturbances": 130,
  };

  Future<void> _predictDiseaseFromServer(BuildContext context) async {
    try {
      // Initialize symptomsIndices with zeros for all features
      final List<int> symptomsIndices = List<int>.filled(132, 0);

      // Set indices to 1 for selected symptoms
      selectedSymptoms.forEach((symptom) {
        final int? index = symptomsMapping[symptom];
        if (index != null) {
          symptomsIndices[index] = 1;
        } else {
          print('Symptom $symptom not found in symptomsMapping');
        }
      });

      final response = await http.post(
        Uri.parse('http://ec2-18-220-246-59.us-east-2.compute.amazonaws.com:5000/predict'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        // Send symptomsIndices as a list of 0s and 1s
        body: jsonEncode(<String, dynamic>{'symptoms': symptomsIndices}),
      );

      print('Request sent with symptoms: $symptomsIndices');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('Response received: $data');

        // Check if the 'prediction' field exists and is not null
        if (data.containsKey('prediction') && data['prediction'] != null) {
          final String prediction = data['prediction'];

          // Update the UI to display the predicted disease
          setState(() {
            predictedDisease = prediction;
            buttonPressed = true; // Set buttonPressed to true when prediction is received
          });
        } else {
          // If 'prediction' field is missing or null, handle it accordingly
          setState(() {
            predictedDisease = 'No prediction available';
          });
        }
      } else {
        throw Exception('Failed to predict disease. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error predicting disease: $error');
    }
  }

  // Add a map to track the visibility of symptoms for each category
  Map<String, bool> categoryVisibility = {};

// Function to toggle visibility of symptoms for a category
  void toggleCategoryVisibility(String category) {
    setState(() {
      if (categoryVisibility.containsKey(category)) {
        categoryVisibility[category] = !categoryVisibility[category]!;
      } else {
        categoryVisibility[category] = true;
      }
    });
  }

// Function to check if symptoms of a category are visible
  bool isCategoryVisible(String category) {
    return categoryVisibility.containsKey(category) ? categoryVisibility[category]! : false;
  }
  bool buttonPressed = false; // Variable to track whether the button is pressed

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff7c77d1).withOpacity(0.5),
                          Color(0xff7c77d1).withOpacity(0.7),
                          Color(0xff7c77d1).withOpacity(0.9),
                          Color(0xff7c77d1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                      ),
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
                      style: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
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
                            child: Image(
                                image: AssetImage("assets/mental-health.png")),
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
                        child: Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            for (var entry in symptomsCategories.entries)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      toggleCategoryVisibility(entry.key);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                                      child: Text(
                                        entry.key,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (isCategoryVisible(entry.key))
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      children: [
                                        for (var symptom in entry.value)
                                          ElevatedButton(
                                            onPressed: () {
                                              _toggleSymptom(symptom);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: _isSymptomSelected(symptom)
                                                  ? myPurple
                                                  : Color(0XFF7E79B7FF),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                            ),
                                            child: Text(
                                              symptom,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              // Display predicted disease only if it's not null and button is pressed
              if (buttonPressed && predictedDisease != null)
                Text('Predicted Disease: ${predictedDisease ?? 'No prediction available'}'),

              Container(
                width: double.infinity,
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Hide the button if buttonPressed is true
                      if (!buttonPressed)
                        ElevatedButton(
                          onPressed: () {
                            // Call function to predict disease
                            // and pass selectedSymptoms list
                            _predictDiseaseFromServer(context);
                          },
                          child: Text('Generate'),
                          style: ButtonStyle(
                            shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(myPurple),
                          ),
                        ),
                    ],
                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }
}