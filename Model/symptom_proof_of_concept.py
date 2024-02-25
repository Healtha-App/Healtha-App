import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.preprocessing import MinMaxScaler, StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.tree import DecisionTreeClassifier

"""**Read the dataset**"""

df = pd.read_csv('symptom.csv')

"""**display the dataset**"""

df

"""**Check null values**"""

sum(df.isnull().sum())

"""**Encoding target values**"""

# Import label encoder
from sklearn import preprocessing
# label_encoder object knows how to understand word labels.
label_encoder = preprocessing.LabelEncoder()
# Encode labels in column 'prognosis'.
df['prognosis']= label_encoder.fit_transform(df['prognosis'])
df

"""**Spliting the data**"""

x = df.iloc[:, :-1].values
y = df.iloc[:, -1].values

xtrain, xtest, ytrain, ytest = train_test_split(x, y, test_size = 0.2, random_state = 22)

"""**Random Forest Classifier**"""

RFA = RandomForestClassifier().fit(xtrain, ytrain)
pre = RFA.predict(xtest)
print(RFA.score(xtest, ytest))

from sklearn.metrics import classification_report
print(classification_report(ytest, pre))

"""**Save Model**"""

import pickle

# Save the model to a file using pickle
with open('RandomForest_model.pkl', 'wb') as model_file:
    pickle.dump(RFA, model_file)



with open('RandomForest_model.pkl', 'rb') as model_file:
    loaded_model = pickle.load(model_file)

preds = loaded_model.predict(np.array([[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0]]))
print(preds[0])

preds = loaded_model.predict(np.array([[0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]]))
print(preds[0])