<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>

    <style>
        body {
            margin: 0;
            font-family: Arial;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(to right, #232526, #414345);
            color: white;
        }

        .form-box {
            background: #2c2c2c;
            padding: 40px;
            border-radius: 12px;
            width: 320px;
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.4);
        }

        h2 {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 12px 0;
            border-radius: 5px;
            border: none;
        }

        input:focus {
            outline: none;
            box-shadow: 0 0 8px #ff4e50;
        }

        button {
            width: 100%;
            padding: 10px;
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

        .error {
            color: #ff4e50;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>

</head>

<body>

<div class="form-box">
    <h2>Admin Login</h2>

    <!-- ERROR MESSAGE -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="error"><%= error %></div>
    <%
        }
    %>

    <form action="login" method="post">

        <input type="text" name="userid" placeholder="Admin ID" required>

        <input type="password" name="password" placeholder="Password" required>

        <button type="submit">Login</button>

    </form>

</div>

</body>
</html>