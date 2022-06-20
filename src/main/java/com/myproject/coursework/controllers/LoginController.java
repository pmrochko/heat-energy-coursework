package com.myproject.coursework.controllers;

import com.myproject.coursework.DAO.UserDAO;
import com.myproject.coursework.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", value = "/login")
public class LoginController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        String email = request.getParameter("email");
        String password = request.getParameter("pass");

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            session.setAttribute("loginStatus", "empty");
            response.sendRedirect("index.jsp");
        } else {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.findUserByEmail(email);

            if (user != null && user.getPassword().equals(password)) {
                if (user.getBanStatus().equals("banned") && user.getBanStatus() != null) {
                    session.setAttribute("loginStatus", "banned");
                    response.sendRedirect("index.jsp");
                } else {
                    session.setAttribute("loginStatus", "success");
                    session.setAttribute("currentUser", user);
                    response.sendRedirect("/user?action=goToProfile");
                }
            } else {
                session.setAttribute("loginStatus", "failed");
                response.sendRedirect("index.jsp");
            }
        }
    }
}