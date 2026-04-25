<!DOCTYPE html>
<html>
<head>
    <title>Heart Disease Prediction</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;

            background: linear-gradient(to right, #0f2027, #203a43, #2c5364);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }

        .container {
            text-align: center;
        }

        .container img {
            width: 120px;
            margin-bottom: 20px;
            animation: heartbeat 1.5s infinite;
        }

        @keyframes heartbeat {
            0% { transform: scale(1); }
            25% { transform: scale(1.6); }
            50% { transform: scale(1); }
            75% { transform: scale(1.3); }
            100% { transform: scale(1); }
        }

        h1 {
            margin-bottom: 30px;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            margin: 10px;
            font-size: 18px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: 0.3s;
        }

        .user-btn {
            background-color: #fff;
            color: #ff4e50;
        }

        .admin-btn {
            background-color: #222;
            color: #fff;
        }

        .btn:hover {
            transform: scale(1.1);
            box-shadow: 0 0 15px rgba(0,0,0,0.3);
        }
    </style>

</head>

<body>

<div class="container">

    <!-- Heart Image -->
    <img src="https://png.pngtree.com/png-vector/20241227/ourmid/pngtree-anatomical-human-heart-png-image_14891515.png" alt="Heart">

    <h1>Heart Disease Prediction System</h1>

    <button class="btn user-btn" onclick="goToUser()">User Panel</button>
    <button class="btn admin-btn" onclick="goToAdmin()">Admin Panel</button>

</div>

<script>
    function goToUser() {
        window.location.href = "login.jsp";
    }

    function goToAdmin() {
        window.location.href = "adminLogin.jsp";
    }
</script>

</body>
</html>