<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Predict</title>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background:
                linear-gradient(rgba(10,10,20,0.9), rgba(20,20,30,0.95)),
                url('https://images.unsplash.com/photo-1576091160550-2173dba999ef');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
            color: white;
        }

        .top-buttons {
            text-align: center;
            margin-top: 20px;
        }

        .logout-btn {
            background: rgba(255,255,255,0.1);
            color: #ff4e50;
            border: 1px solid rgba(255,255,255,0.2);
            padding: 8px 18px;
            border-radius: 25px;
            cursor: pointer;
            margin: 5px;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #ff4e50;
            color: white;
            transform: scale(1.08);
        }

        .form-box {
            margin: 40px auto;
            width: 850px;
            padding: 35px;
            border-radius: 20px;
            backdrop-filter: blur(20px);
            background: rgba(255,255,255,0.05);
            box-shadow: 0 20px 40px rgba(0,0,0,0.7);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 500;
        }

        input, select {
            width: 100%;
            padding: 12px;
            margin: 8px 0;
            border-radius: 8px;
            border: none;
            background: rgba(255,255,255,0.1);
            color: white;
        }

        input::placeholder {
            color: #ccc;
        }

        select {
            color: white;
        }

        select option {
            color: black;
        }

        button[type="submit"] {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #ff4e50, #ff6a00);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            margin-top: 15px;
            font-size: 16px;
            transition: 0.3s;
            box-shadow: 0 10px 25px rgba(255, 78, 80, 0.4);
        }

        button[type="submit"]:hover {
            transform: translateY(-3px) scale(1.03);
        }

        label {
            font-size: 14px;
            opacity: 0.9;
        }

        .field {
            margin-bottom: 10px;
        }

        .info-btn {
            margin-left: 8px;
            padding: 3px 8px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            background: #ff4e50;
            color: white;
        }
    </style>

</head>

<body>

<div class="top-buttons">
    <button class="logout-btn" onclick="logout()">Logout</button>
    <button class="logout-btn" onclick="Dashboard()">Dashboard</button>
</div>

<div class="form-box">

    <h2>Enter Health Details According to your report </h2>

    <form action="predict" method="post">

        Age <button type="button" class="info-btn" onclick="showAgeInfo()">?</button>
        <input type="number" name="Age" placeholder="Age" required>

        RestingBP <button type="button" class="info-btn" onclick="showRestingBPInfo()">?</button>
        <input type="number" name="RestingBP" placeholder="Resting BP" required>

        Cholesterol <button type="button" class="info-btn" onclick="showCholesterolInfo()">?</button>
        <input type="number" name="Cholesterol" placeholder="Cholesterol" required>

        FastingBS <button type="button" class="info-btn" onclick="showFastingBSInfo()">?</button>
        <input type="number" name="FastingBS" placeholder="Fasting Blood Sugar (0/1)" required>

        MaxHR <button type="button" class="info-btn" onclick="showMaxHRInfo()">?</button>
        <input type="number" name="MaxHR" placeholder="Max Heart Rate" required>

        Oldpeak <button type="button" class="info-btn" onclick="showOldpeakInfo()">?</button>
        <input type="text" name="Oldpeak" placeholder="Oldpeak" required>

        Sex <button type="button" class="info-btn" onclick="showSexInfo()">?</button>
        <select name="Sex">
            <option value="M">Male</option>
            <option value="F">Female</option>
        </select>

        ChestPainType <button type="button" class="info-btn" onclick="showChestPainInfo()">?</button>
        <select name="ChestPainType">
            <option value="ATA">ATA</option>
            <option value="NAP">NAP</option>
            <option value="TA">TA</option>
        </select>

        RestingECG <button type="button" class="info-btn" onclick="showRestingECGInfo()">?</button>
        <select name="RestingECG">
            <option value="Normal">Normal</option>
            <option value="ST">ST</option>
        </select>

        ExerciseAngina <button type="button" class="info-btn" onclick="showExerciseAnginaInfo()">?</button>
        <select name="ExerciseAngina">
            <option value="Y">Yes</option>
            <option value="N">No</option>
        </select>

        ST_Slope <button type="button" class="info-btn" onclick="showSTSlopeInfo()">?</button>
        <select name="ST_Slope">
            <option value="Flat">Flat</option>
            <option value="Up">Up</option>
        </select>

        <button type="submit">Predict</button>

    </form>
</div>

<script>
    function logout() {
        window.location.href = "index.jsp";
    }
    function Dashboard() {
        window.location.href = "dashboard.jsp";
    }

        function showCholesterolInfo() {
            alert("Cholesterol is a fatty substance in your blood. Normal levels are usually below 200 mg/dL. High cholesterol can increase the risk of heart disease and blockage in arteries.");
        }
        function showFastingBSInfo() {
            alert("Fasting Blood Sugar (FastingBS) is the blood glucose level after not eating for at least 8 hours. A value above 120 mg/dL may indicate diabetes or higher heart disease risk. 1 for more than 120 and 0 for less than 120");
        }
        function showMaxHRInfo() {
            alert("MaxHR (Maximum Heart Rate) is the highest number of beats per minute your heart reaches during exercise. Lower than expected MaxHR may indicate heart problems.");
        }
        function showOldpeakInfo() {
            alert("Oldpeak represents the depression of the ST segment in ECG during exercise compared to rest. Higher values may indicate reduced blood flow to the heart and possible heart disease.");
        }
        function showSexInfo() {
            alert("Sex refers to the biological gender of the person. It is used because heart disease risk can vary between males and females.");
        }
        function showSTSlopeInfo() {
            alert("ST_Slope describes the slope of the ST segment in ECG during exercise:\nUp: Upward slope (generally normal)\nFlat: Flat slope (may indicate heart issues)\nDown: Downward slope (higher risk of heart disease)");
        }
        function showExerciseAnginaInfo() {
            alert("Exercise Angina indicates whether the person experiences chest pain during physical activity. 'Yes' may suggest reduced blood flow to the heart and higher risk of heart disease.");
        }
        function showRestingECGInfo() {
            alert("RestingECG shows the results of an ECG test at rest:\nNormal: No abnormality\nST: ST-T wave changes (possible heart issue)\nLVH: Left ventricular hypertrophy (thickened heart muscle)");
        }
        function showChestPainInfo() {
            alert("Chest Pain Type describes the kind of chest discomfort:\nTA: Typical Angina (common heart-related pain)\nATA: Atypical Angina (less typical symptoms)\nNAP: Non-Anginal Pain (not heart-related)\nASY: Asymptomatic (no chest pain)");
        }
        function showAgeInfo() {
            alert("Age is the number of years a person has lived. The risk of heart disease generally increases with age.");
        }
        function showRestingBPInfo() {
             alert("Resting Blood Pressure (Resting BP) is the blood pressure when a person is at rest. Normal range is around 90–120 mm Hg. High values may indicate heart-related risks.");
        }
</script>

</body>
</html>