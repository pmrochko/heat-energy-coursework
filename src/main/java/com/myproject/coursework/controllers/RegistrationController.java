package com.myproject.coursework.controllers;

import com.myproject.coursework.DAO.UserDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RegistrationController", value = "/registration")
public class RegistrationController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String repeat_password = request.getParameter("repeat_password");
        String checkbox = request.getParameter("checkbox");

        if (checkbox != null && name != null && email != null && password != null && repeat_password != null &&
                !name.isEmpty() && !email.isEmpty() && !password.isEmpty() && !repeat_password.isEmpty() &&
                password.equals(repeat_password)) {

            UserDAO userDAO = new UserDAO();

            if (userDAO.findUserByEmail(email) == null) {
                boolean success = userDAO.insertUser(email, password, name);
                if (success) session.setAttribute("registrationStatus", "success");
                else session.setAttribute("registrationStatus", "failed");
            } else {
                session.setAttribute("registrationStatus", "emailError");
            }
        } else {
            session.setAttribute("registrationStatus", "failed");
        }

        response.sendRedirect("index.jsp");
    }
}