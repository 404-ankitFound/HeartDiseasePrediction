package project_package.controller;

import project_package.dao.UserDAO;
import project_package.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userid = request.getParameter("userid");
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        UserDAO dao = new UserDAO();

        if (dao.isUserExists(userid)) {
            request.setAttribute("error", "User ID already exists!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }


        User user = new User();
        user.setUserid(userid);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);


        boolean status = dao.registerUser(user);


        if (status) {
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Something went wrong!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}