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
    0: "You have Paroxysmal Positional Vertigo. We advise you to visit a neurologist or Otolaryngology.",
    1: "You have AIDS. We advise you to visit an Immunologist.",
    2: "You have Acne. We advise you to visit a Dermatologist.",
    3: "You have Alcoholic hepatitis. We advise you to visit an Internal medicine physician.",
    4: "You have Allergy. We advise you to visit an Allergist (Immunologist).",
    5: "You have Arthritis. We advise you to visit an Orthopedic doctor.",
    6: "You have Bronchial Asthma. We advise you to visit a Chest doctor.",
    7: "You have Cervical spondylosis. We advise you to visit an Orthopedic doctor.",
    8: "You have Chickenpox. We advise you to visit a Dermatologist.",
    9: "You have Chronic cholestasis. We advise you to visit an Internal medicine physician.",
    10: "You have a Common Cold. We advise you to visit an Internal medicine physician.",
    11: "You have Dengue. We advise you to visit an Orthopedic doctor.",
    12: "You have Diabetes. We advise you to visit an Internal medicine physician.",
    13: "You have Dimorphic hemorrhoids (piles). We advise you to visit a surgeon (Proctology).",
    14: "You have Drug Reaction. We advise you to visit an Allergist or Dermatologist.",
    15: "You have Fungal infection. We advise you to visit a Dermatologist.",
    16: "You have GERD (Gastroesophageal Reflux Disease). We advise you to visit an Internal medicine physician.",
    17: "You have Gastroenteritis. We advise you to visit an Internal medicine physician.",
    18: "You have Heart attack. We advise you to visit a Cardiologist.",
    19: "You have Hepatitis B. We advise you to visit an Internal medicine physician.",
    20: "You have Hepatitis C. We advise you to visit an Internal medicine physician.",
    21: "You have Hepatitis D. We advise you to visit an Internal medicine physician.",
    22: "You have Hepatitis E. We advise you to visit an Internal medicine physician.",
    23: "You have Hypertension. We advise you to visit a Cardiologist.",
    24: "You have Hyperthyroidism. We advise you to visit an Endocrinologist.",
    25: "You have Hypoglycemia. We advise you to visit an Endocrinologist and Diabetologist.",
    26: "You have Hypothyroidism. We advise you to visit an Endocrinologist.",
    27: "You have Impetigo. We advise you to visit a Dermatologist.",
    28: "You have Jaundice. We advise you to visit an Internal medicine physician.",
    29: "You have Malaria. We advise you to visit a Vascular doctor.",
    30: "You have Migraine. We advise you to visit a Neurologist.",
    31: "You have Osteoarthritis. We advise you to visit an Orthopedic doctor.",
    32: "You have Paralysis (brain hemorrhage). We advise you to visit a Neurologist or Physical Medicine and Rehabilitation.",
    33: "You have Peptic ulcer disease. We advise you to visit an Internal medicine physician.",
    34: "You have Pneumonia. We advise you to visit a Chest doctor.",
    35: "You have Psoriasis. We advise you to visit a Dermatologist.",
    36: "You have Tuberculosis. We advise you to visit a Chest doctor (pulmonologist).",
    37: "You have Typhoid. We advise you to visit an Internal medicine physician.",
    38: "You have Urinary tract infection. We advise you to visit a Surgeon (urology).",
    39: "You have Varicose veins. We advise you to visit a surgeon (Vascular Surgery).",
    40: "You have Hepatitis A. We advise you to visit an Internal medicine physician."
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
