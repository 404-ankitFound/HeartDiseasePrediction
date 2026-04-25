from flask import Flask, request, jsonify
import joblib
import pandas as pd

app = Flask(__name__)

model = joblib.load("model.pkl")
expected_columns = joblib.load("columns.pkl")
scaler=joblib.load("scaler.pkl")

@app.route('/predict', methods=['POST'])
def predict():
    data = request.json

    input_dict = {col: 0 for col in expected_columns}


    input_dict['Age'] = int(data['Age'])
    input_dict['RestingBP'] = int(data['RestingBP'])
    input_dict['Cholesterol'] = int(data['Cholesterol'])
    input_dict['FastingBS'] = int(data['FastingBS'])
    input_dict['MaxHR'] = int(data['MaxHR'])
    input_dict['Oldpeak'] = float(data['Oldpeak'])


    if data['Sex'] == 'M':
        input_dict['Sex_M'] = 1


    cp = data['ChestPainType']
    if cp == 'ATA':
        input_dict['ChestPainType_ATA'] = 1
    elif cp == 'NAP':
        input_dict['ChestPainType_NAP'] = 1
    elif cp == 'TA':
        input_dict['ChestPainType_TA'] = 1


    ecg = data['RestingECG']
    if ecg == 'Normal':
        input_dict['RestingECG_Normal'] = 1
    elif ecg == 'ST':
        input_dict['RestingECG_ST'] = 1


    if data['ExerciseAngina'] == 'Y':
        input_dict['ExerciseAngina_Y'] = 1


    slope = data['ST_Slope']
    if slope == 'Flat':
        input_dict['ST_Slope_Flat'] = 1
    elif slope == 'Up':
        input_dict['ST_Slope_Up'] = 1

 
    df = pd.DataFrame([input_dict])

   
    df = df[expected_columns]
    df = scaler.transform(df)
   
    prediction = model.predict(df)[0]

    return jsonify({
        "prediction": int(prediction)
    })

if __name__ == '__main__':
    app.run(debug=True)