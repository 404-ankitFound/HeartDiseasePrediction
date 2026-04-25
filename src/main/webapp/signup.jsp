<!DOCTYPE html>
<html>
<head>
    <title>Signup</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            height: 100vh;
            display: flex;
            background: linear-gradient(to right, #ff4e50, #fc913a);
            justify-content: center;
            align-items: center;
        }

        .form-box {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 350px;
            text-align: center;
        }

        .form-box h2 {
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 6px;
            border: 1px solid #ccc;
            transition: 0.3s;
        }

        input:focus {
            border-color: #ff4e50;
            box-shadow: 0 0 8px #ff4e50;
            outline: none;
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
            margin-top: 10px;
            display: block;
            color: #ff4e50;
            text-decoration: none;
        }

        .link:hover {
            text-decoration: underline;
        }
    </style>

</head>

<body>

<div class="form-box">
    <h2>Create Account</h2>
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div style="color: red; margin-bottom: 10px; font-weight: bold;">
            <%= error %>
        </div>
    <%
        }
    %>
    <form action="signup" method="post" onsubmit="return validateForm()">

        <input type="text" name="userid" id="userid" placeholder="User ID" required>

        <input type="text" name="fullname" placeholder="Full Name" required>

        <input type="email" name="email" placeholder="Email" required>

        <input type="password" name="password" id="password" placeholder="Password" required>

        <input type="password" id="confirmPassword" placeholder="Confirm Password" required>

        <input type="hidden" name="role" value="user">

        <button type="submit">Signup</button>

    </form>

    <a href="login.jsp" class="link">Already have an account? Login</a>
</div>

<script>
    function validateForm() {
        let pass = document.getElementById("password").value;
        let confirm = document.getElementById("confirmPassword").value;

        if (pass !== confirm) {
            alert("Passwords do not match!");
            return false;
        }

        return true;
    }
</script>

</body>
</html>