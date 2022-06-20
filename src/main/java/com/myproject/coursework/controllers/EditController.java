package com.myproject.coursework.controllers;

import com.myproject.coursework.DAO.UserDAO;
import com.myproject.coursework.models.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet(name = "EditServlet", value = "/edit")
public class EditController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currUser = (User) session.getAttribute("currentUser");
        String choice = request.getParameter("form");
        String value;

        if (choice != null) {
            switch (choice) {
                case "surnameForm":
                    value = request.getParameter("surname");
                    if (value != null && !value.isEmpty()) {
                        UserDAO userDAO = new UserDAO();
                        boolean succ = userDAO.updateUserSurname(value, currUser.getID());
                        if (succ) { currUser.setSurname(value); }
                    }
                    break;
                case "nameForm":
                    value = request.getParameter("name");
                    if (value != null && !value.isEmpty()) {
                        UserDAO userDAO = new UserDAO();
                        boolean succ = userDAO.updateUserName(value, currUser.getID());
                        if (succ) { currUser.setName(value); }
                    }
                    break;
                case "emailForm":
                    value = request.getParameter("email");
                    if (value != null && !value.isEmpty()) {
                        UserDAO userDAO = new UserDAO();
                        boolean succ = userDAO.updateUserEmail(value, currUser.getID());
                        if (succ) { currUser.setEmail(value); }
                    }
                    break;
                case "telForm":
                    value = request.getParameter("tel");
                    if (value != null && !value.isEmpty()) {
                        UserDAO userDAO = new UserDAO();
                        boolean succ = userDAO.updateUserTel(value, currUser.getID());
                        if (succ) { currUser.setPhoneNumber(value); }
                    }
                    break;
                case "addrForm":
                    value = request.getParameter("addr");
                    if (value != null && !value.isEmpty()) {
                        UserDAO userDAO = new UserDAO();
                        boolean succ = userDAO.updateUserAddress(value, currUser.getID());
                        if (succ) { currUser.setAddress(value); }
                    }
                    break;
                case "passwordForm":
                    String oldPass = request.getParameter("old-pass");
                    String newPass = request.getParameter("new-pass");
                    String repeatNewPass = request.getParameter("repeat-new-pass");

                    if ((oldPass != null) && (newPass != null) && (repeatNewPass != null) &&
                            (!oldPass.isEmpty()) && (!newPass.isEmpty()) && (!repeatNewPass.isEmpty())) {

                        UserDAO userDAO = new UserDAO();
                        String checkPass = userDAO.findUserByID(currUser.getID()).getPassword();

                        if (oldPass.equals(checkPass) && newPass.equals(repeatNewPass)) {
                            boolean succ = userDAO.updateUserPassword(newPass, currUser.getID());
                            if (succ) {
                                currUser.setPassword(newPass);
                                session.setAttribute("changePassword", "success");
                            } else
                                session.setAttribute("changePassword", "failed");
                        } else
                            session.setAttribute("changePassword", "incorrectInput");
                    } else
                        session.setAttribute("changePassword", "emptyInput");
                    break;
            }
        }

        response.sendRedirect("profile.jsp");
    }

}
