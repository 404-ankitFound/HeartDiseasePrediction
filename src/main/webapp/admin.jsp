<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(rgba(20,20,20,0.9), rgba(20,20,20,0.9)),
                        url('https://images.unsplash.com/photo-1588776814546-ec7e8e5f8b79');
            background-size: cover;
            color: white;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px 40px;
            background: rgba(0,0,0,0.6);
            backdrop-filter: blur(10px);
        }

        .header h2 {
            margin: 0;
            letter-spacing: 1px;
        }

        .logout-btn {
            padding: 8px 18px;
            border: none;
            border-radius: 20px;
            background: #ff4e50;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        .logout-btn:hover {
            background: #e63c3f;
            transform: scale(1.1);
        }

        .container {
            padding: 40px;
        }

        .grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }

        .card {
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(12px);
            padding: 30px;
            border-radius: 15px;
            text-align: center;
            transition: 0.4s;
            border: 1px solid rgba(255,255,255,0.1);
            box-shadow: 0 10px 25px rgba(0,0,0,0.5);
        }

        .card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 20px 40px rgba(255,78,80,0.3);
        }

        .card h2 {
            margin: 10px 0;
            color: #ff4e50;
            font-size: 32px;
        }

        .title {
            font-size: 14px;
            color: #ccc;
            letter-spacing: 1px;
        }

        .footer {
            text-align: center;
            margin-top: 30px;
            color: gray;
            font-size: 12px;
        }
        .container img {
            width: 120px;
            margin-bottom: 20px;
            animation: heartbeat 1.5s infinite;
        }

        @keyframes heartbeat {
            0% { transform: scale(1); }
            25% { transform: scale(1.1); }
            50% { transform: scale(1); }
            75% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }

    </style>

</head>

<body>
<center>

<div class="header">
    <h2>🛠 Admin Dashboard</h2>
    <button class="logout-btn" onclick="logout()">Logout</button>
</div>
<center>
<div class="container">

    <div class="grid">

        <div class="card">
            <div class="title">Total Users</div>
            <h2><%= request.getAttribute("totalUsers") %></h2>
        </div>

        <div class="card">
            <div class="title">Total Predictions</div>
            <h2><%= request.getAttribute("totalPredictions") %></h2>
        </div>
<br>
        <div class="card">
            <div class="title">Predictions (Last 7 Days)</div>
            <h2><%= request.getAttribute("last7") %></h2>
        </div>

        <div class="card">
            <div class="title">Predictions (Last 30 Days)</div>
            <h2><%= request.getAttribute("last30") %></h2>
        </div>
<br>
        <div class="card">
            <div class="title">New Users (7 Days)</div>
            <h2><%= request.getAttribute("users7") %></h2>
        </div>

        <div class="card">
            <div class="title">New Users (30 Days)</div>
            <h2><%= request.getAttribute("users30") %></h2>
        </div>

    </div>

    <div class="footer">
        Heart Disease Prediction System • Admin Panel
    </div>

</div>
<div class="container">

    <!-- Heart Image -->
    <img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" alt="Heart">
    <img src="https://cdn-icons-png.flaticon.com/512/833/833472.png" alt="Heart">

</div>

<script>
    function logout() {
        window.location.href = "index.jsp";
    }
</script>

</body>
</html>