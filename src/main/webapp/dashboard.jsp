<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>

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
                linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.7)),
                url('https://wallpapers.com/images/hd/dark-color-background-lzfzj0rfqjci2tcl.jpg');
            background-size: cover;
            background-position: center;
            min-height: 100vh;
        }

        .header {
            background: rgba(255, 78, 80, 0.9);
            backdrop-filter: blur(10px);
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 5px 20px rgba(0,0,0,0.4);
        }

        .header h2 {
            margin: 0;
            font-weight: 500;
        }

        .logout-btn {
            background: white;
            color: #ff4e50;
            border: none;
            padding: 8px 18px;
            border-radius: 25px;
            cursor: pointer;
            transition: 0.3s;
            font-weight: 500;
        }

        .logout-btn:hover {
            background: #ffe5e5;
            transform: scale(1.08);
        }

        .container {
            padding: 40px;
        }

        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: white;
        }

        .top-bar h3 {
            font-weight: 500;
        }

        .predict-btn {
            padding: 10px 25px;
            background: linear-gradient(45deg, #ff4e50, #ff6a00);
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: 0.3s;
            box-shadow: 0 8px 20px rgba(255, 78, 80, 0.5);
        }

        .predict-btn:hover {
            transform: translateY(-3px) scale(1.05);
        }

        .card {
            margin-top: 25px;
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(15px);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
            color: white;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: rgba(255, 78, 80, 0.9);
            padding: 12px;
        }

        td {
            padding: 12px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.2);
        }

        tr:hover {
            background: rgba(255,255,255,0.05);
            transform: scale(1.01);
            transition: 0.2s;
        }

        .no-data {
            text-align: center;
            padding: 20px;
            color: #ddd;
        }

        .error {
            color: #ff6b6b;
            font-weight: bold;
            margin-bottom: 10px;
        }
    </style>

</head>

<body>

<div class="header">
    <h2>Welcome, <%= session.getAttribute("userid") %></h2>
    <button class="logout-btn" onclick="logout()">Logout</button>
</div>

<div class="container">

    <div class="top-bar">
        <h3>Your Prediction History</h3>
        <button class="predict-btn" onclick="goToPredict()">Predict</button>
    </div>

    <div class="card">

        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="error"><%= error %></div>
        <%
            }
        %>

        <table>
            <tr>
                <th>Date</th>
                <th>Age</th>
                <th>BP</th>
                <th>Cholesterol</th>
                <th>Result</th>
            </tr>

            <%
                project_package.dao.PredictionDAO dao = new project_package.dao.PredictionDAO();
                String userid = (String) session.getAttribute("userid");

                java.sql.ResultSet rs = dao.getUserHistory(userid);

                boolean hasData = false;

                while (rs != null && rs.next()) {
                    hasData = true;
            %>
            <tr>
                <td><%= rs.getDate("prediction_date") %></td>
                <td><%= rs.getInt("age") %></td>
                <td><%= rs.getInt("resting_bp") %></td>
                <td><%= rs.getInt("cholesterol") %></td>
                <td>
                    <%= rs.getInt("prediction_result") == 1 ? " Risk" : " Normal" %>
                </td>
            </tr>
            <%
                }
                if (!hasData) {
            %>
            <tr>
                <td colspan="5" class="no-data">No prediction history available</td>
            </tr>
            <%
                }
            %>

        </table>

    </div>

</div>

<script>
    function goToPredict() {
        window.location.href = "predict.jsp";
    }

    function logout() {
        window.location.href = "index.jsp";
    }
</script>
</body>
</html>