<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Prediction Result</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(to right, #ff4e50, #fc913a);
            color: white;
        }

        .card {
            background: white;
            color: black;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            width: 400px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            margin-bottom: 20px;
        }

        .result {
            font-size: 28px;
            font-weight: bold;
            margin: 20px 0;
        }

        .safe {
            color: green;
        }

        .risk {
            color: red;
        }

        .emoji {
            font-size: 50px;
        }

        button {
            margin-top: 20px;
            padding: 10px 20px;
            background: #ff4e50;
            color: white;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #e63c3f;
            transform: scale(1.05);
        }

        @keyframes fadeIn {
            from {opacity: 0; transform: translateY(20px);}
            to {opacity: 1; transform: translateY(0);}
        }
    </style>

</head>

<body>

<%
    String result = (String) request.getAttribute("result");

    boolean isRisk = false;

    if (result != null && result.contains("1")) {
        isRisk = true;
    }
%>

<div class="card">

    <h1>Prediction Result</h1>

    <div class="emoji">
        <%= isRisk ? "" : "" %>
    </div>

    <div class="result <%= isRisk ? "risk" : "safe" %>">
        <%= isRisk ? "High Risk of Heart Disease" : "No Significant Risk" %>
    </div>

    <p>
        <%= isRisk
            ? "Please consult a medical professional for further evaluation."
            : "Your heart condition appears normal based on provided data." %>
    </p>

    <button onclick="goBack()">Back to Dashboard</button>

</div>

<script>
    function goBack() {
        window.location.href = "dashboard.jsp";
    }
</script>

</body>
</html>