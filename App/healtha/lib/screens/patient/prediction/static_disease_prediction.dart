

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:healtha/localization/generated/l10n.dart';
import 'package:healtha/variables.dart';
import 'package:http/http.dart' as http;

class StaticDisease extends StatefulWidget {
  const StaticDisease({Key? key}) : super(key: key);

  @override
  State<StaticDisease> createState() => _DiseaseState();
}

class _DiseaseState extends State<StaticDisease> {
  static Color myPurple = const Color(0xff7c77d1);

  bool isExpanded = false;
  String predictedDisease = 'Predicted Disease';
  bool buttonPressed = false;

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
      "toxic_look_typhos",
      "red_spots_over_body",
      "dischromic_patches",
      "pus_filled_pimples",
      "blackheads",
      "skin_peeling",
      "silver_like_dusting",
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
      "cold_hands_and_feets",
      "muscle_wasting",
      "joint_pain",
      "swollen_legs",
      "diarrhea"
    ],
    'Neurological Symptoms': [
      "chills",
      "shivering",
      "headache",
      "dizziness",
      "cramps",
      "slurred_speech",
      "loss_of_balance",
      "unsteadiness",
      "weakness_of_one_body_side",
      "altered_sensorium",
      "coma",
    ],
    'Gastrointestinal Symptoms': [
      "acidity",
      "ulcers_on_tongue",
      "vomiting",
      "indigestion",
      "nausea",
      "constipation",
      "abdominal_pain",
      "diarrhoea",
      "swelling_of_stomach",
      "pain_during_bowel_movements",
      "pain_in_anal_region",
      "bloody_stool",
      "irritation_in_anus",
      "passage_of_gases",
      "belly_pain",
      "abnormal_menstruation",
      "stomach_bleeding",
      "distention_of_abdomen",
      "stomach_pain",
    ],
    'Respiratory Symptoms': [
      "continuous_sneezing",
      "cough",
      "breathlessness",
      "phlegm",
      "throat_irritation",
      "redness_of_eyes",
      "sinus_pressure",
      "runny_nose",
      "congestion",
      "mucoid_sputum",
      "rusty_sputum",
      "blood_in_sputum",
    ],
    'Emotional Symptoms': [
      "lack_of_concentration",
      "irritability",
      "depression",
      "lethargy",
      "restlessness",
      "mood_swings",
      "anxiety",
    ],
    'Urinary Symptoms': [
      "burning_micturition",
      "spotting_urination",
      "dark_urine",
      "yellow_urine",
      "bladder_discomfort",
      "foul_smell_of_urine",
      "continuous_feel_of_urine",
      "polyuria",
    ],
    'Cardiovascular Symptoms': [
      "palpitations",
      "enlarged_thyroid",
      "swollen_blood_vessels",
      "fast_heart_rate",
      "chest_pain",
      "swelled_lymph_nodes",
    ],
    'Physical Symptoms': [
      "fatigue",
      "weight_gain",
      "weight_loss",
      "irregular_sugar_level",
      "high_fever",
      "sunken_eyes",
      "loss_of_appetite",
      "mild_fever",
      "yellowing_of_eyes",
      "acute_liver_failure",
      "fluid_overload",
      "malaise",
      "obesity",
      "puffy_face_and_eyes",
      "extra_marital_contacts",
      "spinning_movements",
      "internal_itching",
      "watering_from_eyes",
      "family_history",
      "history_of_alcohol_consumption",
      "receiving_unsterile_injections",
      "receiving_blood_transfusion",
    ],
    'Sensory Symptoms': [
      "pain_behind_the_eyes",
      "blurred_and_distorted_vision",
      "excessive_hunger",
      "loss_of_smell",
      "increased_appetite",
      "visual_disturbances",
    ],
  };

  List<String> selectedSymptoms = [];
  Map<String, bool> categoryVisibility = {};

  @override
  void initState() {
    super.initState();
    _showTextAfterDelay();
  }

  bool _showMessage = false;
  void _showTextAfterDelay() {
    Future.delayed(Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showMessage = true;
        });
      }
    });
  }
  void toggleCategoryVisibility(String category) {
    setState(() {
      categoryVisibility[category] = !(categoryVisibility[category] ?? false);
    });
  }

  bool isCategoryVisible(String category) {
    return categoryVisibility[category] ?? false;
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

  bool _isSymptomSelected(String symptom) {
    return selectedSymptoms.contains(symptom);
  }

  Map<String, int> _generateSymptomInput() {
    Map<String, int> inputDataForModel = {};
    symptomsCategories.values.expand((symptoms) => symptoms).forEach((symptom) {
      inputDataForModel[symptom] = selectedSymptoms.contains(symptom) ? 1 : 0;
    });

    // Print the number of items in the generated input
    print('Number of items in generated input: ${inputDataForModel.length}');

    return inputDataForModel;
  }

  static Map<int, String> disease_mapping = {
    0: "Paroxysmal Positional Vertigo",
    1: "AIDS",
    2: "Acne",
    3: "Alcoholic hepatitis",
    4: "Allergy",
    5: "Arthritis",
    6: "Bronchial Asthma",
    7: "Cervical spondylosis",
    8: "Chickenpox",
    9: "Chronic cholestasis",
    10: "Common Cold",
    11: "Dengue",
    12: "Diabetes",
    13: "Dimorphic hemorrhoids (piles)",
    14: "Drug Reaction",
    15: "Fungal infection",
    16: "GERD (Gastroesophageal Reflux Disease)",
    17: "Gastroenteritis",
    18: "Heart attack",
    19: "Hepatitis B",
    20: "Hepatitis C",
    21: "Hepatitis D",
    22: "Hepatitis E",
    23: "Hypertension",
    24: "Hyperthyroidism",
    25: "Hypoglycemia",
    26: "Hypothyroidism",
    27: "Impetigo",
    28: "Jaundice",
    29: "Malaria",
    30: "Migraine",
    31: "Osteoarthritis",
    32: "Paralysis (brain hemorrhage)",
    33: "Peptic ulcer disease",
    34: "Pneumonia",
    35: "Psoriasis",
    36: "Tuberculosis",
    37: "Typhoid",
    38: "Urinary tract infection",
    39: "Varicose veins",
    40: "Hepatitis A"
  };
  String mapToDisease(int prediction) {
    return disease_mapping[prediction] ?? "Unknown";
  }

  Future<void> _predictDisease() async {
    const url = 'https://model-1-bzs7.onrender.com/';
    final inputDataForModel = _generateSymptomInput();

    // Convert data to JSON string
    final inputJson = jsonEncode(inputDataForModel);
    print(
        'Number of items in input_data_for_model: ${inputDataForModel.length}');
    print('Input data for model: $inputDataForModel');

    try {
      // Send POST request using http package
      final response = await http.post(
        Uri.parse(url),
        body: inputJson,
      );

      if (response.statusCode == 200) {
        final predictedDiseaseIndex = jsonDecode(response.body)['disease'];
        final predictedDisease = disease_mapping[predictedDiseaseIndex];

        // Update predictedDisease and buttonPressed
        setState(() {
          this.predictedDisease = predictedDisease!;
          buttonPressed = true;
        });

        print(S.of(context).Predicted_Disease(predictedDisease!));
      } else {
        // Handle error with status code
        setState(() {
          predictedDisease =
          'Error: Prediction failed. Status code: ${response.statusCode}';
          buttonPressed = true;
        });
      }
    } catch (error) {
      // Handle other exceptions (e.g., network errors)
      setState(() {
        predictedDisease =
        'Error: Unable to get prediction. Check your internet connection.';
        buttonPressed = true;
      });
      print('Error making prediction request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
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
                    borderRadius: const BorderRadius.only(
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
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          //  color: myPurple,
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
                          S.of(context).Your_health_our_priority,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: myPurple,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          S.of(context).Disease_prediction_made_easy,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(
                children: [
                  Text(
                    S.of(context).What_are_you_feeling,
                    textAlign: TextAlign.start,
                    style: TextStyle(

                      fontSize: 18, fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ...symptomsCategories.keys.map((category) {
              return Card(
                color: Theme.of(context).colorScheme.surface,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    border: Border.all(
                      color: AppConfig.myPurple.withOpacity(0.5),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                          category,
                          style:  TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,

                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            toggleCategoryVisibility(category);
                          },
                          icon: Icon(
                            color: Theme.of(context).colorScheme.onPrimary,
                            isCategoryVisible(category)
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ),
                      ),
                      if (isCategoryVisible(category))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: symptomsCategories[category]!.map((symptom) {
                              return CheckboxListTile(
                                title: Text(symptom.replaceAll("_", " ",),style:
                                TextStyle( color: Theme.of(context).colorScheme.onPrimary,
                                ),),
                                value: _isSymptomSelected(symptom),
                                onChanged: (_) {
                                  _toggleSymptom(symptom);
                                },
                                checkColor:Theme.of(context).colorScheme.onPrimary,

                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _predictDisease();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: myPurple,
                padding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                S.of(context).Predict_Disease,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            if (buttonPressed)
              Center(
                child: Text(
                  "Predicted disease: Bronchial Asthma",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
