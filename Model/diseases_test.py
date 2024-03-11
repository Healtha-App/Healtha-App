# server.py
import json

import requests
from flask import Flask, request, jsonify
import pickle
import numpy as np
import pandas as pd

app = Flask(__name__)

# Load your dataset
df = pd.read_csv('symptom.csv')

# Load the trained model
with open('RandomForest_model.pkl', 'rb') as model_file:
    loaded_model = pickle.load(model_file)

# Load the label encoder object
with open('label_encoder.pkl', 'rb') as encoder_file:
    label_encoder = pickle.load(encoder_file)

# Disease mapping dictionary
disease_mapping = {
    0: "Paroymsal Positional Vertigo",
    1: "AIDS",
    2: "Acne",
    3: "Alcoholic hepatitis",
    4: "Allergy",
    5: "Arthritis",
    6: "Bronchial Asthma",
    7: "Cervical spondylosis",
    8: "Chicken pox",
    9: "Chronic cholestasis",
    10: "Common Cold",
    11: "Dengue",
    12: "Diabetes",
    13: "Dimorphic hemmorhoids(piles)",
    14: "Drug Reaction",
    15: "Fungal infection",
    16: "GERD",
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
    31: "Osteoarthristis",
    32: "Paralysis (brain hemorrhage)",
    33: "Peptic ulcer disease",
    34: "Pneumonia",
    35: "Psoriasis",
    36: "Tuberculosis",
    37: "Typhoid",
    38: "Urinary tract infection",
    39: "Varicose veins",
    40: "Hepatitis A"
}
symptoms_mapping = {
    0: "itching",
    1: "skin_rash",
    2: "nodal_skin_eruptions",
    3: "continuous_sneezing",
    4: "shivering",
    5: "chills",
    6: "joint_pain",
    7: "stomach_pain",
    8: "acidity",
    9: "ulcers_on_tongue",
    10: "muscle_wasting",
    11: "vomiting",
    12: "burning_micturition",
    13: "spotting_urination",
    14: "fatigue",
    15: "weight_gain",
    16: "anxiety",
    17: "cold_hands_and_feets",
    18: "mood_swings",
    19: "weight_loss",
    20: "restlessness",
    21: "lethargy",
    22: "patches_in_throat",
    23: "irregular_sugar_level",
    24: "cough",
    25: "high_fever",
    26: "sunken_eyes",
    27: "breathlessness",
    28: "sweating",
    29: "dehydration",
    30: "indigestion",
    31: "headache",
    32: "yellowish_skin",
    33: "dark_urine",
    34: "nausea",
    35: "loss_of_appetite",
    36: "pain_behind_the_eyes",
    37: "back_pain",
    38: "constipation",
    39: "abdominal_pain",
    40: "diarrhoea",
    41: "mild_fever",
    42: "yellow_urine",
    43: "yellowing_of_eyes",
    44: "acute_liver_failure",
    45: "fluid_overload",
    46: "swelling_of_stomach",
    47: "swelled_lymph_nodes",
    48: "malaise",
    49: "blurred_and_distorted_vision",
    50: "phlegm",
    51: "throat_irritation",
    52: "redness_of_eyes",
    53: "sinus_pressure",
    54: "runny_nose",
    55: "congestion",
    56: "chest_pain",
    57: "weakness_in_limbs",
    58: "fast_heart_rate",
    59: "pain_during_bowel_movements",
    60: "pain_in_anal_region",
    61: "bloody_stool",
    62: "irritation_in_anus",
    63: "neck_pain",
    64: "dizziness",
    65: "cramps",
    66: "bruising",
    67: "obesity",
    68: "swollen_legs",
    69: "swollen_blood_vessels",
    70: "puffy_face_and_eyes",
    71: "enlarged_thyroid",
    72: "brittle_nails",
    73: "swollen_extremities",
    74: "excessive_hunger",
    75: "extra_marital_contacts",
    76: "drying_and_tingling_lips",
    77: "slurred_speech",
    78: "knee_pain",
    79: "hip_joint_pain",
    80: "muscle_weakness",
    81: "stiff_neck",
    82: "swelling_joints",
    83: "movement_stiffness",
    84: "spinning_movements",
    85: "loss_of_balance",
    86: "unsteadiness",
    87: "weakness_of_one_body_side",
    88: "loss_of_smell",
    89: "bladder_discomfort",
    90: "foul_smell_of_urine",
    91: "continuous_feel_of_urine",
    92: "passage_of_gases",
    93: "internal_itching",
    94: "toxic_look_(typhos)",
    95: "depression",
    96: "irritability",
    97: "muscle_pain",

    98: "altered_sensorium",
    99: "red_spots_over_body",
    100: "belly_pain",
    101: "abnormal_menstruation",
    102: "dischromic_patches",
    103: "watering_from_eyes",
    104: "increased_appetite",
    105: "polyuria",
    106: "family_history",
    107: "mucoid_sputum",
    108: "rusty_sputum",
    109: "lack_of_concentration",
    110: "visual_disturbances",
    111: "receiving_blood_transfusion",
    112: "receiving_unsterile_injections",
    113: "coma",
    114: "stomach_bleeding",
    115: "distention_of_abdomen",
    116: "history_of_alcohol_consumption",
    117: "fluid_overload",
    118: "blood_in_sputum",
    119: "prominent_veins_on_calf",
    120: "palpitations",
    121: "painful_walking",
    122: "Pus_filled_pimples",
    123: "blackheads",
    124: "scurring",
    125: "skin_peeling",
    126: "Silver_like_dusting",
    127: "small_dents_in_nails",
    128: "inflammatory_nails",
    129: "blister",
    130: "red_sore_around_nose",
    131: "yellow_crust_ooze",
}

@app.route('/symptoms_mapping', methods=['GET'])
def get_symptoms_mapping():
    try:
        # Return the symptoms mapping as a JSON response
        return jsonify({"symptoms_mapping": symptoms_mapping})

    except Exception as e:
        return jsonify({"error": str(e)})

@app.route('/predict', methods=['POST'])
def predict_disease():
    try:
        # Receive symptoms as a JSON-encoded string from the Flutter app
        symptoms_indices = request.json['symptoms']

        # Predict using the loaded model
        preds = loaded_model.predict(np.array([symptoms_indices]))

        # Map the disease number to name using the dictionary
        # Return the result as a JSON response
        return jsonify({"prediction": disease_mapping.get(preds[0], "Unknown Disease")})

    except Exception as e:
        return jsonify({"error": str(e)})

@app.route('/all_symptoms', methods=['GET'])
def get_all_symptoms():
    try:
        # Get all unique symptoms from the dataset
        symptoms = list(df.columns)

        return jsonify({"all_symptoms": symptoms})

    except Exception as e:
        return str(e)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
