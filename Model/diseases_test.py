# server.py
import json

import requests
from flask import Flask, request, jsonify
import pickle
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier


app = Flask(__name__)


"""**Read the dataset**"""

df = pd.read_excel('to_match_categorize.xlsx')

"""**Check null values**"""

sum(df.isnull().sum())

"""**Encoding target values**"""

# Import label encoder
from sklearn import preprocessing
# label_encoder object knows how to understand word labels.
label_encoder = preprocessing.LabelEncoder()
# Encode labels in column 'prognosis'.
df['prognosis']= label_encoder.fit_transform(df['prognosis'])


"""**Spliting the data**"""

x = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

xtrain, xtest, ytrain, ytest = train_test_split(x, y, test_size = 0.2, random_state = 22)


"""**Random Forest Classifier**"""

Random_Forest_Classifier = RandomForestClassifier().fit(xtrain, ytrain)
pre = Random_Forest_Classifier.predict(xtest)
print(Random_Forest_Classifier.score(xtest, ytest))


# Save the model to a file using pickle
with open('Random_Forest_Classifier.pkl', 'wb') as model_file:
    pickle.dump(Random_Forest_Classifier, model_file)

"""Load the Model and test it in random inputs"""

with open('Random_Forest_Classifier.pkl', 'rb') as model_file:
    loaded_model = pickle.load(model_file)


# Disease mapping dictionary
# Disease mapping dictionary
disease_mapping = {
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
}

# Symptoms mapping dictionary
symptoms_mapping = {
    0: "itching",
    1: "skin_rash",
    2: "nodal_skin_eruptions",
    3: "patches_in_throat",
    4: "sweating",
    5: "dehydration",
    6: "yellowish_skin",
    7: "bruising",
    8: "drying_and_tingling_lips",
    9: "toxic_look_(typhos)",
    10: "red_spots_over_body",
    11: "dischromic_patches",
    12: "Pus_filled_pimples",
    13: "blackheads",
    14: "skin_peeling",
    15: "Silver_like_dusting",
    16: "blister",
    17: "red_sore_around_nose",
    18: "yellow_crust_ooze",
    19: "inflammatory_nails",
    20: "small_dents_in_nails",
    21: "scurring",
    22: "painful_walking",
    23: "prominent_veins_on_calf",
    24: "muscle_pain",
    25: "movement_stiffness",
    26: "swelling_joints",
    27: "stiff_neck",
    28: "muscle_weakness",
    29: "hip_joint_pain",
    30: "knee_pain",
    31: "swollen_extremities",
    32: "brittle_nails",
    33: "neck_pain",
    34: "weakness_in_limbs",
    35: "back_pain",
    36: "cold_hands_and_feets",
    37: "muscle_wasting",
    38: "joint_pain",
    39: "swollen_legs",
    40: "chills",
    41: "shivering",
    42: "headache",
    43: "dizziness",
    44: "cramps",
    45: "slurred_speech",
    46: "loss_of_balance",
    47: "unsteadiness",
    48: "weakness_of_one_body_side",
    49: "altered_sensorium",
    50: "coma",
    51: "acidity",
    52: "ulcers_on_tongue",
    53: "vomiting",
    54: "indigestion",
    55: "nausea",
    56: "constipation",
    57: "abdominal_pain",
    58: "diarrhea",
    59: "swelling_of_stomach",
    60: "pain_during_bowel_movements",
    61: "pain_in_anal_region",
    62: "bloody_stool",
    63: "irritation_in_anus",
    64: "passage_of_gases",
    65: "belly_pain",
    66: "abnormal_menstruation",
    67: "stomach_bleeding",
    68: "distention_of_abdomen",
    69: "stomach_pain",
    70: "continuous_sneezing",
    71: "cough",
    72: "Breathlessness",
    73: "Phlegm",
    74: "Throat_irritation",
    75: "redness_of_eyes",
    76: "sinus_pressure",
    77: "runny_nose",
    78: "congestion",
    79: "mucoid_sputum",
    80: "rusty_sputum",
    81: "blood_in_sputum",
    82: "lack_of_concentration",
    83: "irritability",
    84: "depression",
    85: "lethargy",
    86: "restlessness",
    87: "mood_swings",
    88: "anxiety",
    89: "burning_micturition",
    90: "spotting_urination",
    91: "dark_urine",
    92: "yellow_urine",
    93: "bladder_discomfort",
    94: "foul_smell_of_urine",
    95: "continuous_feel_of_urine",
    96: "polyuria",
    97: "palpitations",
    98: "enlarged_thyroid",
    99: "swollen_blood_vessels",
    100: "fast_heart_rate",
    101: "chest_pain",
    102: "swelled_lymph_nodes",
    103: "fatigue",
    104: "weight_gain",
    105: "weight_loss",
    106: "irregular_sugar_level",
    107: "high_fever",
    108: "sunken_eyes",
    109: "loss_of_appetite",
    110: "mild_fever",
    111: "yellowing_of_eyes",
    112: "acute_liver_failure",
    113: "fluid_overload",
    114: "malaise",
    115: "obesity",
    116: "puffy_face_and_eyes",
    117: "extra_marital_contacts",
    118: "spinning_movements",
    119: "internal_itching",
    120: "watering_from_eyes",
    121: "family_history",
    122: "history_of_alcohol_consumption",
    123: "receiving_unsterile_injections",
    124: "receiving_blood_transfusion",
    125: "coma",
    126: "pain_behind_the_eyes",
    127: "blurred_and_distorted_vision",
    128: "excessive_hunger",
    129: "loss_of_smell",
    130: "increased_appetite",
    131: "visual_disturbances",
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
        # Receive symptoms as a JSON-encoded list of 0s and 1s from the Flutter app
        symptoms_indices = request.json['symptoms']

        # Predict using the loaded model
        preds = loaded_model.predict(np.array([symptoms_indices]))

        # Map the disease number to name using the dictionary
        # Return the result as a JSON response
        predicted_disease = disease_mapping.get(preds[0], "Unknown Disease")
        app.logger.info(predicted_disease)
        return jsonify({"prediction": predicted_disease})
    except Exception as e:
        app.logger.error("Error predicting disease: %s", e)
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

