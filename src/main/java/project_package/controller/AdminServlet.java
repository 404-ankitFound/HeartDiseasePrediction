package project_package.controller;

import project_package.dao.AdminDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AdminDAO dao = new AdminDAO();

        int totalUsers = dao.getTotalUsers();
        int totalPredictions = dao.getTotalPredictions();
        int last7 = dao.getPredictionsLast7Days();
        int last30 = dao.getPredictionsLast30Days();
        int users7 = dao.getUsersLast7Days();
        int users30 = dao.getUsersLast30Days();

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("totalPredictions", totalPredictions);
        request.setAttribute("last7", last7);
        request.setAttribute("last30", last30);
        request.setAttribute("users7", users7);
        request.setAttribute("users30", users30);

        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}