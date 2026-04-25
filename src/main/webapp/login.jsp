<!DOCTYPE html>
<html>
<head>
    <title>Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
        }

        /* LEFT SECTION */
        .left {
            width: 50%;
            background: linear-gradient(to bottom right, #ff4e50, #fc913a);
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 50px;
        }

        .left h1 {
            margin-bottom: 20px;
        }

        .left p {
            line-height: 1.6;
            font-size: 16px;
        }

        /* RIGHT SECTION */
        .right {
            width: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #f5f5f5;
        }

        .form-box {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 320px;
            text-align: center;
            transition: 0.3s;
        }

        .form-box:hover {
            transform: translateY(-5px);
        }

        .form-box h2 {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 12px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }

        input:focus {
            border-color: #ff4e50;
            outline: none;
            box-shadow: 0 0 8px #ff4e50;
        }

        button {
            width: 100%;
            padding: 10px;
            background: #ff4e50;
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #e63c3f;
            transform: scale(1.05);
        }

        .link {
            margin-top: 15px;
            display: block;
            color: #ff4e50;
            text-decoration: none;
            font-size: 14px;
        }

        .link:hover {
            text-decoration: underline;
        }

        .error {
            color: red;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>

</head>

<body>

<!-- LEFT SIDE -->
<div class="left">
    <h1>About Us</h1>
    <p>
        Detecting heart disease early is critical, yet analyzing multiple medical parameters manually can be complex and time-consuming.
    </p>
    <p>
        Our system simplifies this process by intelligently evaluating key health indicators from your reports.
    </p>
    <p>
        Using a trained machine learning model with approximately <b>93% accuracy</b>, we provide fast and reliable predictions to help you understand your heart health.
    </p>
</div>

<!-- RIGHT SIDE -->
<div class="right">

    <div class="form-box">
        <h2>User Login</h2>


        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <%
            }
        %>

        <form action="login" method="post">

            <input type="text" name="userid" placeholder="User ID" required>

            <input type="password" name="password" placeholder="Password" required>

            <button type="submit">Login</button>

        </form>

        <a href="signup.jsp" class="link">Don't have an account? Signup</a>

    </div>

</div>

</body>
</html>