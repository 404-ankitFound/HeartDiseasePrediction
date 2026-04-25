package project_package.controller;

import project_package.dao.UserDAO;
import project_package.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userid = request.getParameter("userid");
        String password = request.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.login(userid, password);

        if (user != null) {

            HttpSession session = request.getSession();
            session.setAttribute("userid", user.getUserid());
            session.setAttribute("role", user.getRole());

            if (user.getRole().equals("admin")) {
                response.sendRedirect("admin");
            } else {
                response.sendRedirect("dashboard.jsp");
            }

        } else {
            request.setAttribute("error", "Invalid User ID or Password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}