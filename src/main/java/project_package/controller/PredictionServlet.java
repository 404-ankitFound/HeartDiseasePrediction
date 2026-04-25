package project_package.controller;

import project_package.dao.PredictionDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;

@WebServlet("/predict")
public class PredictionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userid = (String) session.getAttribute("userid");

        PredictionDAO dao = new PredictionDAO();

        if (dao.hasPredictedToday(userid)) {
            request.setAttribute("error", "You have already predicted today!");
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            return;
        }
        String Age = request.getParameter("Age");
        String RestingBP = request.getParameter("RestingBP");
        String Cholesterol = request.getParameter("Cholesterol");
        String FastingBS = request.getParameter("FastingBS");
        String MaxHR = request.getParameter("MaxHR");
        String Oldpeak = request.getParameter("Oldpeak");

        String Sex = request.getParameter("Sex");
        String ChestPainType = request.getParameter("ChestPainType");
        String RestingECG = request.getParameter("RestingECG");
        String ExerciseAngina = request.getParameter("ExerciseAngina");
        String ST_Slope = request.getParameter("ST_Slope");

        String jsonInput = "{"
                + "\"Age\":" + Age + ","
                + "\"RestingBP\":" + RestingBP + ","
                + "\"Cholesterol\":" + Cholesterol + ","
                + "\"FastingBS\":" + FastingBS + ","
                + "\"MaxHR\":" + MaxHR + ","
                + "\"Oldpeak\":" + Oldpeak + ","
                + "\"Sex\":\"" + Sex + "\","
                + "\"ChestPainType\":\"" + ChestPainType + "\","
                + "\"RestingECG\":\"" + RestingECG + "\","
                + "\"ExerciseAngina\":\"" + ExerciseAngina + "\","
                + "\"ST_Slope\":\"" + ST_Slope + "\""
                + "}";

        URL url = new URL("http://127.0.0.1:5000/predict");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setDoOutput(true);

        OutputStream os = conn.getOutputStream();
        os.write(jsonInput.getBytes());
        os.flush();
        os.close();

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream())
        );

        StringBuilder responseStr = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            responseStr.append(line);
        }

        br.close();

        String resultJson = responseStr.toString();

        int resultValue = resultJson.contains("1") ? 1 : 0;

        dao.savePrediction(userid, Age, RestingBP, Cholesterol, String.valueOf(resultValue));

        request.setAttribute("result", resultJson);
        request.getRequestDispatcher("result.jsp").forward(request, response);
    }
}