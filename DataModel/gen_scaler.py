import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
import joblib
import os

script_dir = os.path.dirname(os.path.abspath(__file__))

df = pd.read_csv(os.path.join(script_dir, "heart.csv"))
df['Cholesterol'] = df['Cholesterol'].replace(0, df.loc[df['Cholesterol'] != 0, 'Cholesterol'].mean())
df['RestingBP']   = df['RestingBP'].replace(0,   df.loc[df['RestingBP']   != 0, 'RestingBP'].mean())

df_encoded = pd.get_dummies(df, drop_first=True).astype(int)
X = df_encoded.drop('HeartDisease', axis=1)
y = df_encoded['HeartDisease']

X_train, _, y_train, _ = train_test_split(X, y, stratify=y, test_size=0.2, random_state=42)

scaler = StandardScaler()
scaler.fit(X_train)
joblib.dump(scaler, os.path.join(script_dir, 'scaler.pkl'))
print("scaler.pkl written.")
